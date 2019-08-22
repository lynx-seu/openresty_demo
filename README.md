
## Questions
------------

Q: nginx cann't resolve other container(redis) hostname?

A: add `resolver 127.0.0.11;` in `server`
    [reference](https://github.com/docker/compose/issues/3412#issuecomment-472323332)


Q: openresty rewrite or redirect?

A: [refer](https://blog.csdn.net/weiyuefei/article/details/38434797)
