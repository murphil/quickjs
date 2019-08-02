FROM nnurphy/qjs:apk-all as q
FROM alpine:3.10
COPY --from=q /usr/local/bin/qjs /usr/local/bin
CMD [ "qjs" ]