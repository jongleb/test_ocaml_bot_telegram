open Base

type t = (int, Int.comparator_witness) Set.t

let set: t ref = ref(Set.empty (module Int))

let add chat_id = set := Set.add !set chat_id

let to_list () = Set.to_list !set