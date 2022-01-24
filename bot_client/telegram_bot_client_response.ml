type chat = {
  id: int;
} [@@deriving yojson { strict = false}]
type message = {
  text: string;
} [@@deriving yojson { strict = false}]

type update = {
  update_id: int;
  message: message;
  chat: chat;
} [@@deriving yojson { strict = false}]

type updates = update list

type response = {
  result: update list;
} [@@deriving yojson { strict = false}]