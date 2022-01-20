
type message = {
  text: string;
} [@@deriving yojson]

type update = {
  update_id: int;
  message: message;
} [@@deriving yojson]

type updates = update list

type response = {
  result: update list;
} [@@deriving yojson]