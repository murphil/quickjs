FROM nnurphy/qjs:apk-all as q
COPY --from=q /usr/local/bin/qjs /usr/local/bin
CMD [ "qjs" ]