type fail_request_status = {
  code: int;
  body: string;
  url: string;
}

type ping_result = Success | Timeout of float | Fail of fail_request_status