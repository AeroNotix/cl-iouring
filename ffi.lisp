;;; This file was automatically generated by SWIG (http://www.swig.org).
;;; Version 3.0.12
;;;
;;; Do not make changes to this file unless you know what you are doing--modify
;;; the SWIG interface file instead.

(in-package #:cl-iouring)



;;;SWIG wrapper code starts here

(cl:defmacro defanonenum (cl:&body enums)
   "Converts anonymous enums to defconstants."
  `(cl:progn ,@(cl:loop for value in enums
                        for index = 0 then (cl:1+ index)
                        when (cl:listp value) do (cl:setf index (cl:second value)
                                                          value (cl:first value))
                        collect `(cl:defconstant ,value ,index))))

(cl:eval-when (:compile-toplevel :load-toplevel)
  (cl:unless (cl:fboundp 'swig-lispify)
    (cl:defun swig-lispify (name flag cl:&optional (package cl:*package*))
      (cl:labels ((helper (lst last rest cl:&aux (c (cl:car lst)))
                    (cl:cond
                      ((cl:null lst)
                       rest)
                      ((cl:upper-case-p c)
                       (helper (cl:cdr lst) 'upper
                               (cl:case last
                                 ((lower digit) (cl:list* c #\- rest))
                                 (cl:t (cl:cons c rest)))))
                      ((cl:lower-case-p c)
                       (helper (cl:cdr lst) 'lower (cl:cons (cl:char-upcase c) rest)))
                      ((cl:digit-char-p c)
                       (helper (cl:cdr lst) 'digit 
                               (cl:case last
                                 ((upper lower) (cl:list* c #\- rest))
                                 (cl:t (cl:cons c rest)))))
                      ((cl:char-equal c #\_)
                       (helper (cl:cdr lst) '_ (cl:cons #\- rest)))
                      (cl:t
                       (cl:error "Invalid character: ~A" c)))))
        (cl:let ((fix (cl:case flag
                        ((constant enumvalue) "+")
                        (variable "*")
                        (cl:t ""))))
          (cl:intern
           (cl:concatenate
            'cl:string
            fix
            (cl:nreverse (helper (cl:concatenate 'cl:list name) cl:nil cl:nil))
            fix)
           package))))))

;;;SWIG wrapper code ends here


(cl:defconstant _XOPEN_SOURCE 500)

(cffi:defcstruct io_uring_sq
	(khead :pointer)
	(ktail :pointer)
	(kring_mask :pointer)
	(kring_entries :pointer)
	(kflags :pointer)
	(kdropped :pointer)
	(array :pointer)
	(sqes :pointer)
	(sqe_head :unsigned-int)
	(sqe_tail :unsigned-int)
	(ring_sz :pointer)
	(ring_ptr :pointer)
	(pad :pointer :count 4))

(cffi:defcstruct io_uring_cq
	(khead :pointer)
	(ktail :pointer)
	(kring_mask :pointer)
	(kring_entries :pointer)
	(kflags :pointer)
	(koverflow :pointer)
	(cqes :pointer)
	(ring_sz :pointer)
	(ring_ptr :pointer)
	(pad :pointer :count 4))

(cffi:defcstruct io_uring
	(sq io_uring_sq)
	(cq io_uring_cq)
	(flags :unsigned-int)
	(ring_fd :int)
	(features :unsigned-int)
	(pad :pointer :count 3))

(cffi:defcfun ("io_uring_get_probe_ring" io_uring_get_probe_ring) :pointer
  (ring :pointer))

(cffi:defcfun ("io_uring_get_probe" io_uring_get_probe) :pointer)

(cffi:defcfun ("io_uring_free_probe" io_uring_free_probe) :void
  (probe :pointer))

(cffi:defcfun ("io_uring_opcode_supported" io_uring_opcode_supported) :int
  (p :pointer)
  (op :int))

(cffi:defcfun ("io_uring_queue_init_params" io_uring_queue_init_params) :int
  (entries :unsigned-int)
  (ring :pointer)
  (p :pointer))

(cffi:defcfun ("io_uring_queue_init" io_uring_queue_init) :int
  (entries :unsigned-int)
  (ring :pointer)
  (flags :unsigned-int))

(cffi:defcfun ("io_uring_queue_mmap" io_uring_queue_mmap) :int
  (fd :int)
  (p :pointer)
  (ring :pointer))

(cffi:defcfun ("io_uring_ring_dontfork" io_uring_ring_dontfork) :int
  (ring :pointer))

(cffi:defcfun ("io_uring_queue_exit" io_uring_queue_exit) :void
  (ring :pointer))

(cffi:defcfun ("io_uring_peek_batch_cqe" io_uring_peek_batch_cqe) :unsigned-int
  (ring :pointer)
  (cqes :pointer)
  (count :unsigned-int))

(cffi:defcfun ("io_uring_wait_cqes" io_uring_wait_cqes) :int
  (ring :pointer)
  (cqe_ptr :pointer)
  (wait_nr :unsigned-int)
  (ts :pointer)
  (sigmask :pointer))

(cffi:defcfun ("io_uring_wait_cqe_timeout" io_uring_wait_cqe_timeout) :int
  (ring :pointer)
  (cqe_ptr :pointer)
  (ts :pointer))

(cffi:defcfun ("io_uring_submit" io_uring_submit) :int
  (ring :pointer))

(cffi:defcfun ("io_uring_submit_and_wait" io_uring_submit_and_wait) :int
  (ring :pointer)
  (wait_nr :unsigned-int))

(cffi:defcfun ("io_uring_get_sqe" io_uring_get_sqe) :pointer
  (ring :pointer))

(cffi:defcfun ("io_uring_register_buffers" io_uring_register_buffers) :int
  (ring :pointer)
  (iovecs :pointer)
  (nr_iovecs :unsigned-int))

(cffi:defcfun ("io_uring_register_buffers_tags" io_uring_register_buffers_tags) :int
  (ring :pointer)
  (iovecs :pointer)
  (tags :pointer)
  (nr :unsigned-int))

(cffi:defcfun ("io_uring_register_buffers_update_tag" io_uring_register_buffers_update_tag) :int
  (ring :pointer)
  (off :unsigned-int)
  (iovecs :pointer)
  (tags :pointer)
  (nr :unsigned-int))

(cffi:defcfun ("io_uring_unregister_buffers" io_uring_unregister_buffers) :int
  (ring :pointer))

(cffi:defcfun ("io_uring_register_files" io_uring_register_files) :int
  (ring :pointer)
  (files :pointer)
  (nr_files :unsigned-int))

(cffi:defcfun ("io_uring_register_files_tags" io_uring_register_files_tags) :int
  (ring :pointer)
  (files :pointer)
  (tags :pointer)
  (nr :unsigned-int))

(cffi:defcfun ("io_uring_register_files_update_tag" io_uring_register_files_update_tag) :int
  (ring :pointer)
  (off :unsigned-int)
  (files :pointer)
  (tags :pointer)
  (nr_files :unsigned-int))

(cffi:defcfun ("io_uring_unregister_files" io_uring_unregister_files) :int
  (ring :pointer))

(cffi:defcfun ("io_uring_register_files_update" io_uring_register_files_update) :int
  (ring :pointer)
  (off :unsigned-int)
  (files :pointer)
  (nr_files :unsigned-int))

(cffi:defcfun ("io_uring_register_eventfd" io_uring_register_eventfd) :int
  (ring :pointer)
  (fd :int))

(cffi:defcfun ("io_uring_register_eventfd_async" io_uring_register_eventfd_async) :int
  (ring :pointer)
  (fd :int))

(cffi:defcfun ("io_uring_unregister_eventfd" io_uring_unregister_eventfd) :int
  (ring :pointer))

(cffi:defcfun ("io_uring_register_probe" io_uring_register_probe) :int
  (ring :pointer)
  (p :pointer)
  (nr :unsigned-int))

(cffi:defcfun ("io_uring_register_personality" io_uring_register_personality) :int
  (ring :pointer))

(cffi:defcfun ("io_uring_unregister_personality" io_uring_unregister_personality) :int
  (ring :pointer)
  (id :int))

(cffi:defcfun ("io_uring_register_restrictions" io_uring_register_restrictions) :int
  (ring :pointer)
  (res :pointer)
  (nr_res :unsigned-int))

(cffi:defcfun ("io_uring_enable_rings" io_uring_enable_rings) :int
  (ring :pointer))

(cffi:defcfun ("__io_uring_sqring_wait" __io_uring_sqring_wait) :int
  (ring :pointer))

(cffi:defcfun ("io_uring_register_iowq_aff" io_uring_register_iowq_aff) :int
  (ring :pointer)
  (cpusz :pointer)
  (mask :pointer))

(cffi:defcfun ("io_uring_unregister_iowq_aff" io_uring_unregister_iowq_aff) :int
  (ring :pointer))

(cffi:defcfun ("io_uring_register_iowq_max_workers" io_uring_register_iowq_max_workers) :int
  (ring :pointer)
  (values :pointer))

(cffi:defcfun ("__io_uring_get_cqe" __io_uring_get_cqe) :int
  (ring :pointer)
  (cqe_ptr :pointer)
  (submit :unsigned-int)
  (wait_nr :unsigned-int)
  (sigmask :pointer))

(cffi:defcfun ("io_uring_cq_advance" io_uring_cq_advance) :void
  (ring :pointer)
  (nr :unsigned-int))

(cffi:defcfun ("io_uring_cqe_seen" io_uring_cqe_seen) :void
  (ring :pointer)
  (cqe :pointer))

(cffi:defcfun ("io_uring_sqe_set_data" io_uring_sqe_set_data) :void
  (sqe :pointer)
  (data :pointer))

(cffi:defcfun ("io_uring_cqe_get_data" io_uring_cqe_get_data) :pointer
  (cqe :pointer))

(cffi:defcfun ("io_uring_sqe_set_flags" io_uring_sqe_set_flags) :void
  (sqe :pointer)
  (flags :unsigned-int))

(cffi:defcfun ("__io_uring_set_target_fixed_file" __io_uring_set_target_fixed_file) :void
  (sqe :pointer)
  (file_index :unsigned-int))

(cffi:defcfun ("io_uring_prep_rw" io_uring_prep_rw) :void
  (op :int)
  (sqe :pointer)
  (fd :int)
  (addr :pointer)
  (len :unsigned-int)
  (offset :pointer))

(cffi:defcfun ("io_uring_prep_splice" io_uring_prep_splice) :void
  (sqe :pointer)
  (fd_in :int)
  (off_in :pointer)
  (fd_out :int)
  (off_out :pointer)
  (nbytes :unsigned-int)
  (splice_flags :unsigned-int))

(cffi:defcfun ("io_uring_prep_tee" io_uring_prep_tee) :void
  (sqe :pointer)
  (fd_in :int)
  (fd_out :int)
  (nbytes :unsigned-int)
  (splice_flags :unsigned-int))

(cffi:defcfun ("io_uring_prep_readv" io_uring_prep_readv) :void
  (sqe :pointer)
  (fd :int)
  (iovecs :pointer)
  (nr_vecs :unsigned-int)
  (offset :pointer))

(cffi:defcfun ("io_uring_prep_read_fixed" io_uring_prep_read_fixed) :void
  (sqe :pointer)
  (fd :int)
  (buf :pointer)
  (nbytes :unsigned-int)
  (offset :pointer)
  (buf_index :int))

(cffi:defcfun ("io_uring_prep_writev" io_uring_prep_writev) :void
  (sqe :pointer)
  (fd :int)
  (iovecs :pointer)
  (nr_vecs :unsigned-int)
  (offset :pointer))

(cffi:defcfun ("io_uring_prep_write_fixed" io_uring_prep_write_fixed) :void
  (sqe :pointer)
  (fd :int)
  (buf :pointer)
  (nbytes :unsigned-int)
  (offset :pointer)
  (buf_index :int))

(cffi:defcfun ("io_uring_prep_recvmsg" io_uring_prep_recvmsg) :void
  (sqe :pointer)
  (fd :int)
  (msg :pointer)
  (flags :unsigned-int))

(cffi:defcfun ("io_uring_prep_sendmsg" io_uring_prep_sendmsg) :void
  (sqe :pointer)
  (fd :int)
  (msg :pointer)
  (flags :unsigned-int))

(cffi:defcfun ("__io_uring_prep_poll_mask" __io_uring_prep_poll_mask) :unsigned-int
  (poll_mask :unsigned-int))

(cffi:defcfun ("io_uring_prep_poll_add" io_uring_prep_poll_add) :void
  (sqe :pointer)
  (fd :int)
  (poll_mask :unsigned-int))

(cffi:defcfun ("io_uring_prep_poll_multishot" io_uring_prep_poll_multishot) :void
  (sqe :pointer)
  (fd :int)
  (poll_mask :unsigned-int))

(cffi:defcfun ("io_uring_prep_poll_remove" io_uring_prep_poll_remove) :void
  (sqe :pointer)
  (user_data :pointer))

(cffi:defcfun ("io_uring_prep_poll_update" io_uring_prep_poll_update) :void
  (sqe :pointer)
  (old_user_data :pointer)
  (new_user_data :pointer)
  (poll_mask :unsigned-int)
  (flags :unsigned-int))

(cffi:defcfun ("io_uring_prep_fsync" io_uring_prep_fsync) :void
  (sqe :pointer)
  (fd :int)
  (fsync_flags :unsigned-int))

(cffi:defcfun ("io_uring_prep_nop" io_uring_prep_nop) :void
  (sqe :pointer))

(cffi:defcfun ("io_uring_prep_timeout" io_uring_prep_timeout) :void
  (sqe :pointer)
  (ts :pointer)
  (count :unsigned-int)
  (flags :unsigned-int))

(cffi:defcfun ("io_uring_prep_timeout_remove" io_uring_prep_timeout_remove) :void
  (sqe :pointer)
  (user_data :pointer)
  (flags :unsigned-int))

(cffi:defcfun ("io_uring_prep_timeout_update" io_uring_prep_timeout_update) :void
  (sqe :pointer)
  (ts :pointer)
  (user_data :pointer)
  (flags :unsigned-int))

(cffi:defcfun ("io_uring_prep_accept" io_uring_prep_accept) :void
  (sqe :pointer)
  (fd :int)
  (addr :pointer)
  (addrlen :pointer)
  (flags :int))

(cffi:defcfun ("io_uring_prep_accept_direct" io_uring_prep_accept_direct) :void
  (sqe :pointer)
  (fd :int)
  (addr :pointer)
  (addrlen :pointer)
  (flags :int)
  (file_index :unsigned-int))

(cffi:defcfun ("io_uring_prep_cancel" io_uring_prep_cancel) :void
  (sqe :pointer)
  (user_data :pointer)
  (flags :int))

(cffi:defcfun ("io_uring_prep_link_timeout" io_uring_prep_link_timeout) :void
  (sqe :pointer)
  (ts :pointer)
  (flags :unsigned-int))

(cffi:defcfun ("io_uring_prep_connect" io_uring_prep_connect) :void
  (sqe :pointer)
  (fd :int)
  (addr :pointer)
  (addrlen :pointer))

(cffi:defcfun ("io_uring_prep_files_update" io_uring_prep_files_update) :void
  (sqe :pointer)
  (fds :pointer)
  (nr_fds :unsigned-int)
  (offset :int))

(cffi:defcfun ("io_uring_prep_fallocate" io_uring_prep_fallocate) :void
  (sqe :pointer)
  (fd :int)
  (mode :int)
  (offset :pointer)
  (len :pointer))

(cffi:defcfun ("io_uring_prep_openat" io_uring_prep_openat) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (flags :int)
  (mode :pointer))

(cffi:defcfun ("io_uring_prep_openat_direct" io_uring_prep_openat_direct) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (flags :int)
  (mode :pointer)
  (file_index :unsigned-int))

(cffi:defcfun ("io_uring_prep_close" io_uring_prep_close) :void
  (sqe :pointer)
  (fd :int))

(cffi:defcfun ("io_uring_prep_read" io_uring_prep_read) :void
  (sqe :pointer)
  (fd :int)
  (buf :pointer)
  (nbytes :unsigned-int)
  (offset :pointer))

(cffi:defcfun ("io_uring_prep_write" io_uring_prep_write) :void
  (sqe :pointer)
  (fd :int)
  (buf :pointer)
  (nbytes :unsigned-int)
  (offset :pointer))

(cffi:defcfun ("io_uring_prep_statx" io_uring_prep_statx) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (flags :int)
  (mask :unsigned-int)
  (statxbuf :pointer))

(cffi:defcfun ("io_uring_prep_fadvise" io_uring_prep_fadvise) :void
  (sqe :pointer)
  (fd :int)
  (offset :pointer)
  (len :pointer)
  (advice :int))

(cffi:defcfun ("io_uring_prep_madvise" io_uring_prep_madvise) :void
  (sqe :pointer)
  (addr :pointer)
  (length :pointer)
  (advice :int))

(cffi:defcfun ("io_uring_prep_send" io_uring_prep_send) :void
  (sqe :pointer)
  (sockfd :int)
  (buf :pointer)
  (len :pointer)
  (flags :int))

(cffi:defcfun ("io_uring_prep_recv" io_uring_prep_recv) :void
  (sqe :pointer)
  (sockfd :int)
  (buf :pointer)
  (len :pointer)
  (flags :int))

(cffi:defcfun ("io_uring_prep_openat2" io_uring_prep_openat2) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (how :pointer))

(cffi:defcfun ("io_uring_prep_openat2_direct" io_uring_prep_openat2_direct) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (how :pointer)
  (file_index :unsigned-int))

(cffi:defcfun ("io_uring_prep_epoll_ctl" io_uring_prep_epoll_ctl) :void
  (sqe :pointer)
  (epfd :int)
  (fd :int)
  (op :int)
  (ev :pointer))

(cffi:defcfun ("io_uring_prep_provide_buffers" io_uring_prep_provide_buffers) :void
  (sqe :pointer)
  (addr :pointer)
  (len :int)
  (nr :int)
  (bgid :int)
  (bid :int))

(cffi:defcfun ("io_uring_prep_remove_buffers" io_uring_prep_remove_buffers) :void
  (sqe :pointer)
  (nr :int)
  (bgid :int))

(cffi:defcfun ("io_uring_prep_shutdown" io_uring_prep_shutdown) :void
  (sqe :pointer)
  (fd :int)
  (how :int))

(cffi:defcfun ("io_uring_prep_unlinkat" io_uring_prep_unlinkat) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (flags :int))

(cffi:defcfun ("io_uring_prep_renameat" io_uring_prep_renameat) :void
  (sqe :pointer)
  (olddfd :int)
  (oldpath :string)
  (newdfd :int)
  (newpath :string)
  (flags :int))

(cffi:defcfun ("io_uring_prep_sync_file_range" io_uring_prep_sync_file_range) :void
  (sqe :pointer)
  (fd :int)
  (len :unsigned-int)
  (offset :pointer)
  (flags :int))

(cffi:defcfun ("io_uring_prep_mkdirat" io_uring_prep_mkdirat) :void
  (sqe :pointer)
  (dfd :int)
  (path :string)
  (mode :pointer))

(cffi:defcfun ("io_uring_prep_symlinkat" io_uring_prep_symlinkat) :void
  (sqe :pointer)
  (target :string)
  (newdirfd :int)
  (linkpath :string))

(cffi:defcfun ("io_uring_prep_linkat" io_uring_prep_linkat) :void
  (sqe :pointer)
  (olddfd :int)
  (oldpath :string)
  (newdfd :int)
  (newpath :string)
  (flags :int))

(cffi:defcfun ("io_uring_sq_ready" io_uring_sq_ready) :unsigned-int
  (ring :pointer))

(cffi:defcfun ("io_uring_sq_space_left" io_uring_sq_space_left) :unsigned-int
  (ring :pointer))

(cffi:defcfun ("io_uring_sqring_wait" io_uring_sqring_wait) :int
  (ring :pointer))

(cffi:defcfun ("io_uring_cq_ready" io_uring_cq_ready) :unsigned-int
  (ring :pointer))

(cffi:defcfun ("io_uring_cq_eventfd_enabled" io_uring_cq_eventfd_enabled) :pointer
  (ring :pointer))

(cffi:defcfun ("io_uring_cq_eventfd_toggle" io_uring_cq_eventfd_toggle) :int
  (ring :pointer)
  (enabled :pointer))

(cffi:defcfun ("io_uring_wait_cqe_nr" io_uring_wait_cqe_nr) :int
  (ring :pointer)
  (cqe_ptr :pointer)
  (wait_nr :unsigned-int))

(cffi:defcfun ("io_uring_peek_cqe" io_uring_peek_cqe) :int
  (ring :pointer)
  (cqe_ptr :pointer))

(cffi:defcfun ("io_uring_wait_cqe" io_uring_wait_cqe) :int
  (ring :pointer)
  (cqe_ptr :pointer))

(cffi:defcfun ("io_uring_mlock_size" io_uring_mlock_size) :pointer
  (entries :unsigned-int)
  (flags :unsigned-int))

(cffi:defcfun ("io_uring_mlock_size_params" io_uring_mlock_size_params) :pointer
  (entries :unsigned-int)
  (p :pointer))


