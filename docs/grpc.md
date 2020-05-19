# gRPC

## Using metadata

https://github.com/grpc/grpc-go/blob/master/Documentation/grpc-metadata.md

## Monitoring

- [@peterbourgon](https://twitter.com/peterbourgon/status/1224436045334237191)

> one Histogram per service for request duration, label for method (gRPC method, HTTP route, etc.), label for result (gRPC or HTTP status code), 10–20 buckets — should be no problem

- [https://alex.dzyoba.com/blog/go-prometheus-service](https://alex.dzyoba.com/blog/go-prometheus-service/)

> - **R**equest rate
> - **E**rrors
> - **D**uration (latency) distribution

- [https://www.weave.works/blog/of-metrics-and-middleware/](https://www.weave.works/blog/of-metrics-and-middleware/)