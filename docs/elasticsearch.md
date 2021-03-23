# Elasticsearch

## Delete logstash index

Delete selected month

```
curl -XDELETE http://localhost:9200/logstash-2021.02.*
```

Or entire history

```
curl -XDELETE http://localhost:9200/logstash*
```
