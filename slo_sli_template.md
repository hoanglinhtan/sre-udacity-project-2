# API Service

| Category      | SLI                                                            | SLO                                                                                                         |   |   |   |   |   |   |   |
|---------------|----------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|---|---|---|---|---|---|---|
| Availability  | Total number of successful requests / total number of requests | 99%                                                                                                         |   |   |   |   |   |   |   |
| Latency       | Buckets of requests in a histogram showing the 90th percentile | 90% of requests below 100ms                                                                                 |   |   |   |   |   |   |   |
| Error Budget  | The percentage of failed requests over a given period of time (1 - Availability)                                                              | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |   |   |   |   |   |   |   |
| Throughput    | Amount of successful requests over given time period (ex: 5, 10 mins)                            | 5 RPS indicates the application is functioning                                                              |   |   |   |   |   |   |   |
|               |                                                                |                                   
