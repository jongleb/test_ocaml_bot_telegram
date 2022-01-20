
type message = {
  text: string;
} [@@deriving yojson]

type update = {
  update_id: int;
  message: message;
} [@@deriving yojson]

type response = {
  result: update list;
} [@@deriving yojson]