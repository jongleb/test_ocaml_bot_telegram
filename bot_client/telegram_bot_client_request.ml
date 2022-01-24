type request = {
  chat_id: int;
  text: string;
} [@@deriving yojson { strict = false}]