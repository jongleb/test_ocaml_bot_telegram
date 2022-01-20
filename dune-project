(lang dune 2.9)

(name telegram_bot)

(generate_opam_files true)

(package
 (name telegram_bot)
 (synopsis "A library for test project")
 (description "Test project")
 (depends
  (alcotest :with-test)
  (ocaml
   (= 4.13.1))
  (lwt
   (>= 5.5.0))
  (cohttp-lwt-unix
   (= 5.0.0))
  (cohttp-async
   (= 5.0.0))
  (yojson
   (= 1.7.0))
  (ppx_deriving_yojson
   (= 3.6.1))))
