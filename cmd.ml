open Core
open Yojson.Basic.Util
open Out_channel
open Lwt
open Cohttp_lwt_unix

let rec print_list = function
  | [] -> ()
  | e :: l ->
      print_string e;
      print_string " ";
      print_list l

let () =
  let cmds = Sys.get_argv () in
  let url = cmds.(1) in
  let body =
    Client.get (Uri.of_string url) >>= fun (_, body) ->
    body |> Cohttp_lwt.Body.to_string >|= fun body -> body
  in
  let json = Lwt_main.run body in
  let json_object = Yojson.Basic.from_string json in
  (* Test that the two values are the same *)
  let dependencies = json_object |> member "devDependencies" |> keys in
  print_string "npm i -D ";
  print_list dependencies;
  print_endline "";
  let dependencies = json_object |> member "dependencies" |> keys in
  print_string "npm i ";
  print_list dependencies
