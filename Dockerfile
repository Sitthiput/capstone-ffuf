# use golang image for pull binary ffuf
FROM golang:alpine AS builder

# workdir at /app
WORKDIR /app

# download ffuf -> binary goes to /go/bin/ffuf
RUN go install github.com/ffuf/ffuf@latest

# as runner
FROM python:3.9-alpine AS production

# copy ffuf from builder
COPY --from=builder /go/bin/ffuf /code/app/ffuf/ffuf

# workdir at /code
WORKDIR /code

# copy requirement.txt
COPY requirement.txt requirement.txt

# install dependencies
RUN python -m pip install --no-cache-dir -r requirement.txt

# copy app
COPY . .

# mod file to be executable
RUN chmod +x /code/app/ffuf/start.sh

# expose port
EXPOSE 8000

# run program
CMD ["python", "main.py"]