open Core
open Yojson.Basic.Util

let js = Yojson.Basic.from_channel (In_channel.create "package.json")

let rec print_list = function
  | [] -> ()
  | e :: l ->
      print_string e;
      print_string " ";
      print_list l

let () =
  let cmds = Sys.get_argv () in
  let cmd = cmds.(1) in
  match cmd with
  | "dev" ->
      let json2 = Yojson.Basic.from_file "package.json" in
      (* Test that the two values are the same *)
      let dependencies = json2 |> member "devDependencies" |> keys in
      print_string "npm i -D ";
      print_list dependencies
  | "dep" ->
      let json2 = Yojson.Basic.from_file "package.json" in
      (* Test that the two values are the same *)
      let dependencies = json2 |> member "dependencies" |> keys in
      print_string "npm i ";
      print_list dependencies
  | _ -> ()
