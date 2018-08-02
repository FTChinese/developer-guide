## Load Test

### Vegeta

开始测试
```
vegeta attack -targets=targets.txt -rate=60 -duration=60s > results.bin
```

生成报告
```
vegeta report -inputs=results.bin > results.txt
vegeta report -inputs=results.bin -reporter=plot > plot.html
```
