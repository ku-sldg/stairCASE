/*
 * Copyright 2019, Data61
 * Commonwealth Scientific and Industrial Research Organisation (CSIRO)
 * ABN 41 687 119 230.
 *
 * This software may be distributed and modified according to the terms of
 * the BSD 2-Clause license. Note that NO WARRANTY is provided.
 * See "LICENSE_BSD2.txt" for details.
 *
 * @TAG(DATA61_BSD)
 */

#include <autoconf.h>
#include <camkes.h>
#include <stdio.h>
#include <virtqueue.h>
#include <camkes/virtqueue.h>
#include <utils/util.h>
#include <string.h>

#include <net/ethernet.h>
#include <netinet/ether.h>
#include <netinet/in.h>
#include <netinet/ip_icmp.h>
#include <arpa/inet.h>

#define ICMP_MSG_SIZE 64 - sizeof(struct icmphdr)
#define IPV4_LENGTH 4

virtqueue_device_t vm_recv_virtqueue;
virtqueue_driver_t vm_send_virtqueue;
void handle_recv_callback(virtqueue_device_t *vq);
void handle_send_callback(virtqueue_driver_t *vq);

virtqueue_device_t key_recv_virtqueue;
virtqueue_driver_t key_send_virtqueue;
void handle_key_recv_callback(virtqueue_device_t *vq);
void handle_key_send_callback(virtqueue_driver_t *vq);

virtqueue_device_t am_recv_virtqueue;
virtqueue_driver_t am_send_virtqueue;
void handle_am_recv_callback(virtqueue_device_t *vq);
void handle_am_send_callback(virtqueue_driver_t *vq);

int send_outgoing_packet(char *outgoing_data, size_t outgoing_data_size, virtqueue_driver_t destination)
{
    void *buf = NULL;
    int err = camkes_virtqueue_buffer_alloc(&destination, &buf, outgoing_data_size);
    if (err) {
        return -1;
    }
    memcpy(buf, outgoing_data, outgoing_data_size);
    if (camkes_virtqueue_driver_send_buffer(&destination, buf, outgoing_data_size) != 0) {
        camkes_virtqueue_buffer_free(&destination, buf);
        return -1;
    }
    destination.notify();
    return 0;
}

void flag_packet(char* packet, size_t packet_size)
{
    // always forward to am for now
    
    // First 4 characters of the packet (ignoring the ethernet header) specify
    // the destination component to which the packet will be forwarded
    
    char payload[ETHERMTU];
    memcpy( payload, packet + sizeof(struct ethhdr), packet_size - sizeof(struct ethhdr) );

    char dest[4];
    memcpy( dest, payload, 4 );

    if( strcmp( dest, "KEYM" ) == 0 )
    {
        ZF_LOGE("Got a packet, sending to Key Manager...");
        send_outgoing_packet( packet, packet_size, key_send_virtqueue );
        return;
    }

    ZF_LOGE("Got a packet, sending to AM...");
    send_outgoing_packet( packet, packet_size, am_send_virtqueue );
    return;
}

void print_ip_packet(void *ip_buf, size_t ip_length)
{
    struct iphdr *ip = ip_buf;
    struct icmphdr *icmp = ip_buf + sizeof(struct iphdr);

    unsigned char *ip_packet = (unsigned char *)ip_buf;
    printf("Packet Contents:");
    for (int i = 0; i < ip_length; i++) {
        if (i % 15 == 0) {
            printf("\n%d:\t", i);
        }
        printf("%x ", ip_packet[i]);
    }
    printf("\n");

    struct in_addr saddr = {ip->saddr};
    struct in_addr daddr = {ip->daddr};
    printf("IP Header - Version: IPv%d protocol: %d | src address: %s",
           ip->version, ip->protocol, inet_ntoa(saddr));
    printf(" | dest address: %s\n", inet_ntoa(daddr));
    printf("ICMP Header - Type: %d | id: %d | seq: %d\n",
           icmp->type, icmp->un.echo.id, icmp->un.echo.sequence);
    printf("\n");
}

/*
** Received from vm
** Send to whomever is indicated
** NOTE: for now, always send to AM
*/
void handle_recv_callback(virtqueue_device_t *vq)
{
    void *buf = NULL;
    size_t buf_size = 0;
    vq_flags_t flag;
    virtqueue_ring_object_t handle;
    if (!virtqueue_get_available_buf(vq, &handle)) {
        ZF_LOGE("Client virtqueue dequeue failed");
        return;
    }

    while (camkes_virtqueue_device_gather_buffer(vq, &handle, &buf, &buf_size, &flag) >= 0) {
        flag_packet( (char*)buf, buf_size );
    }

    if (!virtqueue_add_used_buf(&vm_recv_virtqueue, &handle, 0)) {
        ZF_LOGE("Unable to enqueue used recv buffer");
        return;
    }

    vm_recv_virtqueue.notify();
}

/*
** Send to vm
*/
void handle_send_callback(virtqueue_driver_t *vq)
{
    void *buf = NULL;
    size_t buf_size = 0, wr_len = 0;
    vq_flags_t flag;
    virtqueue_ring_object_t handle;
    if (!virtqueue_get_used_buf(vq, &handle, &wr_len)) {
        ZF_LOGE("Client virtqueue dequeue failed");
        return;
    }

    while (camkes_virtqueue_driver_gather_buffer(vq, &handle, &buf, &buf_size, &flag) >= 0) {
        /* Clean up and free the buffer we allocated */
        camkes_virtqueue_buffer_free(vq, buf);
    }
}

/*
** Received from key_manager
** Send to vm
*/
void handle_key_recv_callback(virtqueue_device_t *vq)
{
    void *buf = NULL;
    size_t buf_size = 0;
    vq_flags_t flag;
    virtqueue_ring_object_t handle;
    if (!virtqueue_get_available_buf(vq, &handle)) {
        ZF_LOGE("Client virtqueue dequeue failed");
        return;
    }

    while (camkes_virtqueue_device_gather_buffer(vq, &handle, &buf, &buf_size, &flag) >= 0) {
        send_outgoing_packet( (char*) buf, buf_size, vm_send_virtqueue );
    }

    if (!virtqueue_add_used_buf(&key_recv_virtqueue, &handle, 0)) {
        ZF_LOGE("Unable to enqueue used key_recv buffer");
        return;
    }

    key_recv_virtqueue.notify();
}

/*
** Send to vm
*/
void handle_key_send_callback(virtqueue_driver_t *vq)
{
    void *buf = NULL;
    size_t buf_size = 0, wr_len = 0;
    vq_flags_t flag;
    virtqueue_ring_object_t handle;
    if (!virtqueue_get_used_buf(vq, &handle, &wr_len)) {
        ZF_LOGE("Client virtqueue dequeue failed");
        return;
    }

    while (camkes_virtqueue_driver_gather_buffer(vq, &handle, &buf, &buf_size, &flag) >= 0) {
        /* Clean up and free the buffer we allocated */
        camkes_virtqueue_buffer_free(vq, buf);
    }
}

/*
** Received from attestation_manager
** Send to vm
*/
void handle_am_recv_callback(virtqueue_device_t *vq)
{
    void *buf = NULL;
    size_t buf_size = 0;
    vq_flags_t flag;
    virtqueue_ring_object_t handle;
    if (!virtqueue_get_available_buf(vq, &handle)) {
        ZF_LOGE("Client virtqueue dequeue failed");
        return;
    }

    while (camkes_virtqueue_device_gather_buffer(vq, &handle, &buf, &buf_size, &flag) >= 0) {
        // forward to the vm
        send_outgoing_packet( (char*) buf, buf_size, vm_send_virtqueue );
    }

    if (!virtqueue_add_used_buf(&am_recv_virtqueue, &handle, 0)) {
        ZF_LOGE("Unable to enqueue used am_recv buffer");
        return;
    }

    am_recv_virtqueue.notify();
}

/*
** Send to vm
*/
void handle_am_send_callback(virtqueue_driver_t *vq)
{
    void *buf = NULL;
    size_t buf_size = 0, wr_len = 0;
    vq_flags_t flag;
    virtqueue_ring_object_t handle;
    if (!virtqueue_get_used_buf(vq, &handle, &wr_len)) {
        ZF_LOGE("Client virtqueue dequeue failed");
        return;
    }

    while (camkes_virtqueue_driver_gather_buffer(vq, &handle, &buf, &buf_size, &flag) >= 0) {
        /* Clean up and free the buffer we allocated */
        camkes_virtqueue_buffer_free(vq, buf);
    }
}


void ping_wait_callback(void)
{
    if (VQ_DEV_POLL(&vm_recv_virtqueue)) {
        handle_recv_callback(&vm_recv_virtqueue);
    }

    if (VQ_DRV_POLL(&vm_send_virtqueue)) {
        handle_send_callback(&vm_send_virtqueue);
    }

    if (VQ_DEV_POLL(&key_recv_virtqueue)) {
        handle_key_recv_callback(&key_recv_virtqueue);
    }

    if (VQ_DRV_POLL(&key_send_virtqueue)) {
        handle_send_callback(&key_send_virtqueue);
    }

    if (VQ_DEV_POLL(&am_recv_virtqueue)) {
        handle_am_recv_callback(&am_recv_virtqueue);
    }

    if (VQ_DRV_POLL(&am_send_virtqueue)) {
        handle_send_callback(&am_send_virtqueue);
    }
}

int run(void)
{
    ZF_LOGE("Starting flagger component");

    // for vm!
    /* Initialise recv virtqueue */
    int err = camkes_virtqueue_device_init(&vm_recv_virtqueue, 0);
    if (err) {
        ZF_LOGE("Unable to initialise vm_recv virtqueue");
        return 1;
    }

    /* Initialise send virtqueue */
    err = camkes_virtqueue_driver_init(&vm_send_virtqueue, 1);
    if (err) {
        ZF_LOGE("Unable to initialise vm_send virtqueue");
        return 1;
    }

    // For keys!
    /* Initialise recv virtqueue */
    err = camkes_virtqueue_device_init(&key_recv_virtqueue, 2);
    if (err) {
        ZF_LOGE("Unable to initialise key_recv virtqueue");
        return 1;
    }

    /* Initialise send virtqueue */
    err = camkes_virtqueue_driver_init(&key_send_virtqueue, 3);
    if (err) {
        ZF_LOGE("Unable to initialise key_send virtqueue");
        return 1;
    }

    // For am!
    /* Initialise recv virtqueue */
    err = camkes_virtqueue_device_init(&am_recv_virtqueue, 4);
    if (err) {
        ZF_LOGE("Unable to initialise am_recv virtqueue");
        return 1;
    }

    /* Initialise send virtqueue */
    err = camkes_virtqueue_driver_init(&am_send_virtqueue, 5);
    if (err) {
        ZF_LOGE("Unable to initialise am_send virtqueue");
        return 1;
    }

    return 0;
}
