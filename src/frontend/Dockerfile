# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:20.04 as builder

ENV GOLANG_VERSION 1.17

ARG SONARIO_GH_TOKEN

RUN apt update && apt install -y build-essential wget sudo busybox net-tools
# Install Go
RUN wget https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz
RUN rm -f go${GOLANG_VERSION}.linux-amd64.tar.gz
ENV PATH "$PATH:/usr/local/go/bin"

RUN apt-get install -y ca-certificates git libffi-dev zlib1g-dev libedit-dev libc++-11-dev libc++abi-11-dev

ENV GO111MODULE=on
RUN go env -w GOPRIVATE=github.com/Rookout/GoRook
# Why all the echos? It hides the credentials from showing up partially. If they show up partially then Jenkins won't censor them.
RUN echo && echo && echo && git config --global url."https://${SONARIO_GH_TOKEN}@github.com".insteadOf "https://github.com"
ENV GOROOK_OS_TAG=ubuntu20

WORKDIR /src
COPY . .
RUN go mod download
RUN go build -tags=${GOROOK_OS_TAG} -gcflags='-N -l' -o /go/bin/frontend .

FROM builder as release

ARG GIT_COMMIT=unspecified
ENV ROOKOUT_COMMIT=$GIT_COMMIT

ARG GIT_ORIGIN=unspecified
ENV ROOKOUT_REMOTE_ORIGIN=$GIT_ORIGIN


RUN sudo apt-get autoclean
WORKDIR /frontend
COPY --from=builder /go/bin/frontend /frontend/server
COPY ./templates ./templates
COPY ./static ./static
EXPOSE 8080
ENTRYPOINT ["/frontend/server"]
