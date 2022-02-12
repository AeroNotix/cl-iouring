
(include "sys/types.h")
(include "inttypes.h")
(include "liburing.h")
(in-package #:iouring)



(defwrapper ("io_uring_opcode_supported" io_uring_opcode_supported) :int
  (p :pointer)
  (op :int))

(defwrapper ("io_uring_cq_advance" io_uring_cq_advance) :void
  (ring :pointer)
  (nr :unsigned-int))

(defwrapper ("io_uring_cqe_seen" io_uring_cqe_seen) :void
  (ring :pointer)
  (cqe :pointer))

(defwrapper ("io_uring_sqe_set_data" io_uring_sqe_set_data) :void
  (sqe :pointer)
  (data :pointer))

(defwrapper ("io_uring_cqe_get_data" io_uring_cqe_get_data) :pointer
  (cqe :pointer))

(defwrapper ("io_uring_sqe_set_flags" io_uring_sqe_set_flags) :void
  (sqe :pointer)
  (flags :unsigned-int))

(defwrapper ("__io_uring_set_target_fixed_file" __io_uring_set_target_fixed_file) :void
  (sqe :pointer)
  (file_index :unsigned-int))

(defwrapper ("io_uring_prep_rw" io_uring_prep_rw) :void
  (op :int)
  (sqe :pointer)
  (fd :int)
  (addr :pointer)
  (len :unsigned-int)
  (offset :unsigned-long-long))

(defwrapper ("io_uring_prep_splice" io_uring_prep_splice) :void
  (sqe :pointer)
  (fd_in :int)
  (off_in :int64-t)
  (fd_out :int)
  (off_out :int64-t)
  (nbytes :unsigned-int)
  (splice_flags :unsigned-int))

(defwrapper ("io_uring_prep_tee" io_uring_prep_tee) :void
  (sqe :pointer)
  (fd_in :int)
  (fd_out :int)
  (nbytes :unsigned-int)
  (splice_flags :unsigned-int))

(defwrapper ("io_uring_prep_readv" io_uring_prep_readv) :void
  (sqe :pointer)
  (fd :int)
  (iovecs :pointer)
  (nr_vecs :unsigned-int)
  (offset :unsigned-long-long))

(defwrapper ("io_uring_prep_read_fixed" io_uring_prep_read_fixed) :void
  (sqe :pointer)
  (fd :int)
  (buf :pointer)
  (nbytes :unsigned-int)
  (offset :unsigned-long-long)
  (buf_index :int))

(defwrapper ("io_uring_prep_writev" io_uring_prep_writev) :void
  (sqe :pointer)
  (fd :int)
  (iovecs :pointer)
  (nr_vecs :unsigned-int)
  (offset :unsigned-long-long))

(defwrapper ("io_uring_prep_write_fixed" io_uring_prep_write_fixed) :void
  (sqe :pointer)
  (fd :int)
  (buf :pointer)
  (nbytes :unsigned-int)
  (offset :unsigned-long-long)
  (buf_index :int))

(defwrapper ("io_uring_prep_recvmsg" io_uring_prep_recvmsg) :void
  (sqe :pointer)
  (fd :int)
  (msg :pointer)
  (flags :unsigned-int))

(defwrapper ("io_uring_prep_sendmsg" io_uring_prep_sendmsg) :void
  (sqe :pointer)
  (fd :int)
  (msg :pointer)
  (flags :unsigned-int))

(defwrapper ("__io_uring_prep_poll_mask" __io_uring_prep_poll_mask) :unsigned-int
  (poll_mask :unsigned-int))

(defwrapper ("io_uring_prep_poll_add" io_uring_prep_poll_add) :void
  (sqe :pointer)
  (fd :int)
  (poll_mask :unsigned-int))

(defwrapper ("io_uring_prep_poll_multishot" io_uring_prep_poll_multishot) :void
  (sqe :pointer)
  (fd :int)
  (poll_mask :unsigned-int))

(defwrapper ("io_uring_prep_poll_remove" io_uring_prep_poll_remove) :void
  (sqe :pointer)
  (user_data :pointer))

(defwrapper ("io_uring_prep_poll_update" io_uring_prep_poll_update) :void
  (sqe :pointer)
  (old_user_data :pointer)
  (new_user_data :pointer)
  (poll_mask :unsigned-int)
  (flags :unsigned-int))

(defwrapper ("io_uring_prep_fsync" io_uring_prep_fsync) :void
  (sqe :pointer)
  (fd :int)
  (fsync_flags :unsigned-int))

(defwrapper ("io_uring_prep_nop" io_uring_prep_nop) :void
  (sqe :pointer))

(defwrapper ("io_uring_prep_timeout" io_uring_prep_timeout) :void
  (sqe :pointer)
  (ts :pointer)
  (count :unsigned-int)
  (flags :unsigned-int))

(defwrapper ("io_uring_prep_timeout_remove" io_uring_prep_timeout_remove) :void
  (sqe :pointer)
  (user_data :unsigned-long-long)
  (flags :unsigned-int))

(defwrapper ("io_uring_prep_timeout_update" io_uring_prep_timeout_update) :void
  (sqe :pointer)
  (ts :pointer)
  (user_data :unsigned-long-long)
  (flags :unsigned-int))

(defwrapper ("io_uring_prep_accept" io_uring_prep_accept) :void
  (sqe :pointer)
  (fd :int)
  (addr :pointer)
  (addrlen :pointer)
  (flags :int))

(defwrapper ("io_uring_prep_accept_direct" io_uring_prep_accept_direct) :void
  (sqe :pointer)
  (fd :int)
  (addr :pointer)
  (addrlen :pointer)
  (flags :int)
  (file_index :unsigned-int))

(defwrapper ("io_uring_prep_cancel" io_uring_prep_cancel) :void
  (sqe :pointer)
  (user_data :pointer)
  (flags :int))

(defwrapper ("io_uring_prep_link_timeout" io_uring_prep_link_timeout) :void
  (sqe :pointer)
  (ts :pointer)
  (flags :unsigned-int))

(defwrapper ("io_uring_prep_connect" io_uring_prep_connect) :void
  (sqe :pointer)
  (fd :int)
  (addr :pointer)
  (addrlen :socklen-t))

(defwrapper ("io_uring_prep_files_update" io_uring_prep_files_update) :void
  (sqe :pointer)
  (fds :pointer)
  (nr_fds :unsigned-int)
  (offset :int))

(defwrapper ("io_uring_prep_fallocate" io_uring_prep_fallocate) :void
  (sqe :pointer)
  (fd :int)
  (mode :int)
  (offset :unsigned-int)
  (len :unsigned-int))

(defwrapper ("io_uring_prep_openat" io_uring_prep_openat) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (flags :int)
  (mode :unsigned-int))

(defwrapper ("io_uring_prep_openat_direct" io_uring_prep_openat_direct) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (flags :int)
  (mode :unsigned-int)
  (file_index :unsigned-int))

(defwrapper ("io_uring_prep_close" io_uring_prep_close) :void
  (sqe :pointer)
  (fd :int))

(defwrapper ("io_uring_prep_read" io_uring_prep_read) :void
  (sqe :pointer)
  (fd :int)
  (buf :pointer)
  (nbytes :unsigned-int)
  (offset :unsigned-long-long))

(defwrapper ("io_uring_prep_write" io_uring_prep_write) :void
  (sqe :pointer)
  (fd :int)
  (buf :pointer)
  (nbytes :unsigned-int)
  (offset :unsigned-long-long))

(defwrapper ("io_uring_prep_statx" io_uring_prep_statx) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (flags :int)
  (mask :unsigned-int)
  (statxbuf :pointer))

(defwrapper ("io_uring_prep_fadvise" io_uring_prep_fadvise) :void
  (sqe :pointer)
  (fd :int)
  (offset :unsigned-long-long)
  (len :unsigned-int)
  (advice :int))

(defwrapper ("io_uring_prep_madvise" io_uring_prep_madvise) :void
  (sqe :pointer)
  (addr :pointer)
  (length :unsigned-int)
  (advice :int))

(defwrapper ("io_uring_prep_send" io_uring_prep_send) :void
  (sqe :pointer)
  (sockfd :int)
  (buf :pointer)
  (len :size-t)
  (flags :int))

(defwrapper ("io_uring_prep_recv" io_uring_prep_recv) :void
  (sqe :pointer)
  (sockfd :int)
  (buf :pointer)
  (len :size-t)
  (flags :int))

(defwrapper ("io_uring_prep_openat2" io_uring_prep_openat2) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (how :pointer))

(defwrapper ("io_uring_prep_openat2_direct" io_uring_prep_openat2_direct) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (how :pointer)
  (file_index :unsigned-int))

(defwrapper ("io_uring_prep_epoll_ctl" io_uring_prep_epoll_ctl) :void
  (sqe :pointer)
  (epfd :int)
  (fd :int)
  (op :int)
  (ev :pointer))

(defwrapper ("io_uring_prep_provide_buffers" io_uring_prep_provide_buffers) :void
  (sqe :pointer)
  (addr :pointer)
  (len :int)
  (nr :int)
  (bgid :int)
  (bid :int))

(defwrapper ("io_uring_prep_remove_buffers" io_uring_prep_remove_buffers) :void
  (sqe :pointer)
  (nr :int)
  (bgid :int))

(defwrapper ("io_uring_prep_shutdown" io_uring_prep_shutdown) :void
  (sqe :pointer)
  (fd :int)
  (how :int))

(defwrapper ("io_uring_prep_unlinkat" io_uring_prep_unlinkat) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (flags :int))

(defwrapper ("io_uring_prep_renameat" io_uring_prep_renameat) :void
  (sqe :pointer)
  (olddfd :int)
  (oldpath :string)
  (newdfd :int)
  (newpath :string)
  (flags :int))

(defwrapper ("io_uring_prep_sync_file_range" io_uring_prep_sync_file_range) :void
  (sqe :pointer)
  (fd :int)
  (len :unsigned-int)
  (offset :unsigned-long-long)
  (flags :int))

(defwrapper ("io_uring_prep_mkdirat" io_uring_prep_mkdirat) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (mode :unsigned-int))

(defwrapper ("io_uring_prep_symlinkat" io_uring_prep_symlinkat) :void
  (sqe :pointer)
  (target :string)
  (newdirfd :int)
  (linkpath :string))

(defwrapper ("io_uring_prep_linkat" io_uring_prep_linkat) :void
  (sqe :pointer)
  (olddfd :int)
  (oldpath :string)
  (newdfd :int)
  (newpath :string)
  (flags :int))

(defwrapper ("io_uring_sq_ready" io_uring_sq_ready) :unsigned-int
  (ring :pointer))

(defwrapper ("io_uring_sq_space_left" io_uring_sq_space_left) :unsigned-int
  (ring :pointer))

(defwrapper ("io_uring_sqring_wait" io_uring_sqring_wait) :int
  (ring :pointer))

(defwrapper ("io_uring_cq_ready" io_uring_cq_ready) :unsigned-int
  (ring :pointer))

(defwrapper ("io_uring_cq_eventfd_enabled" io_uring_cq_eventfd_enabled) :bool
  (ring :pointer))

(defwrapper ("io_uring_cq_eventfd_toggle" io_uring_cq_eventfd_toggle) :int
  (ring :pointer)
  (enabled :bool))

(defwrapper ("io_uring_wait_cqe_nr" io_uring_wait_cqe_nr) :int
  (ring :pointer)
  (cqe_ptr :pointer)
  (wait_nr :unsigned-int))

(defwrapper ("io_uring_peek_cqe" io_uring_peek_cqe) :int
  (ring :pointer)
  (cqe_ptr :pointer))

(defwrapper ("io_uring_wait_cqe" io_uring_wait_cqe) :int
  (ring :pointer)
  (cqe_ptr :pointer))

