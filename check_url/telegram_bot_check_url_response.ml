type fail_request_status = {
  code: int;
  body: string;
  url: string;
}

type timeout_request_status = { url: string; timeout: float }

type ping_result = Success | Timeout of timeout_request_status | Fail of fail_request_status