FROM ubuntu:22.04 AS builder

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libjsoncpp-dev \
    libssl-dev \
    uuid-dev \
    zlib1g-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/drogonframework/drogon.git && \
    cd drogon && \
    git submodule update --init --recursive && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_INSTALL_PREFIX=/usr/local/drogon \
          -DBUILD_SHARED_LIBS=OFF \
          -DBUILD_EXAMPLES=OFF \
          -DBUILD_TESTING=OFF .. && \
    make -j$(nproc) && \
    make install

WORKDIR /app
COPY main.cpp .

RUN g++ -std=c++17 -o season-api main.cpp \
    -I/usr/local/drogon/include \
    -I/usr/include/jsoncpp \
    -L/usr/local/drogon/lib \
    -ldrogon -ltrantor -ljsoncpp -lssl -lcrypto -lz -luuid -lpthread \
    -Wl,-rpath=/usr/local/drogon/lib

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    libjsoncpp25 \
    libssl3 \
    uuid-runtime \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /app/season-api .

EXPOSE 8080
CMD ["./season-api"]
