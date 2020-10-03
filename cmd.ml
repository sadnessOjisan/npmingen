open Core
open Yojson.Basic.Util
open Out_channel

let js = Yojson.Basic.from_channel (In_channel.create "package.json")

let rec print_list = function
  | [] -> ()
  | e :: l ->
      print_string e;
      print_string " ";
      print_list l

let () =
  let json2 = Yojson.Basic.from_file "package.json" in
      (* Test that the two values are the same *)
      let dependencies = json2 |> member "devDependencies" |> keys in
      print_string "npm i -D ";
      print_list dependencies;
      print_endline "";
      let dependencies = json2 |> member "dependencies" |> keys in
      print_string "npm i ";
      print_list dependencies
