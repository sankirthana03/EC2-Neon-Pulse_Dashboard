FROM python:3.12-slim AS build
ADD . /app
WORKDIR /app
RUN pip install --prefix=/devops -r requirements.txt

FROM python:3.12-slim AS runtime
LABEL project="pythonproject"
COPY --from=build /app /aws
COPY --from=build /devops /usr/local
WORKDIR /aws
EXPOSE 5001
CMD ["python3", "app.py"]
