open Lwt
open Lwt.Syntax

open Cohttp_lwt_unix

include Telegram_bot_check_url_response

type t = {
  timeout: float;
  url: string;
}

let make timeout url = { timeout; url }

let compute ~time ~f =
  Lwt.pick
    [
      (f () >|= fun v -> `Done v)
    ; (Lwt_unix.sleep time >|= fun () -> `Timeout)
    ]

let done_to_success url r b = 
  let code = r |> Response.status |> Cohttp.Code.code_of_status in
  let+ body = Cohttp_lwt.Body.to_string b in

  if code == 200 then 
    Success
  else
    Fail({ url; code; body }) 


let ping { timeout; url } = 
  let before = Unix.time() in 

  let get () = Client.get (Uri.of_string url) in
  let* result = compute ~time:timeout ~f:get in

  let after = Unix.time() in
  let diff = after -. before in

  match result with
  | `Done(r, b) -> done_to_success url r b
  | `Timeout -> Lwt.return (Timeout({ timeout=diff; url; }))