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


FROM golang:1.18-alpine as builder
RUN apk --update --no-cache add curl make git gcc musl-dev protobuf-dev openssl-libs-static openssl-dev build-base zlib-static

ENV GO111MODULE=on
ENV GOROOK_OS_TAG=alpine314

WORKDIR /src
COPY . .
RUN go mod download
RUN go build -tags=${GOROOK_OS_TAG},rookout_static -gcflags="all=-dwarflocationlists=true" -o /go/bin/frontend .

FROM golang:1.18-alpine as release
RUN apk add --update --no-cache ca-certificates

ARG GIT_COMMIT=unspecified
ENV ROOKOUT_COMMIT=$GIT_COMMIT

ARG GIT_ORIGIN=unspecified
ENV ROOKOUT_REMOTE_ORIGIN=$GIT_ORIGIN

WORKDIR /frontend
COPY --from=builder /go/bin/frontend /frontend/server
COPY ./templates ./templates
COPY ./static ./static
EXPOSE 8080
ENTRYPOINT ["/frontend/server"]
