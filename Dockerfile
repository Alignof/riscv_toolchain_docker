FROM ghcr.io/alignof/riscv-tests-docker:master

RUN pacman -Syyu --noconfirm dtc
RUN git clone https://github.com/riscv-software-src/riscv-isa-sim.git \
    && mkdir -p /riscv-isa-sim/build \
    && cd /riscv-isa-sim/build \
    && ../configure --prefix=/opt/riscv \
    && make && make install 
RUN git clone https://github.com/riscv-software-src/riscv-pk.git \
    && mkdir -p /riscv-pk/build \
    && cd /riscv-pk/build \
    && ../configure --prefix=/opt/riscv --host=riscv64-unknown-elf --with-arch=rv64gc_zifencei \
    && make && make install 
RUN cp /opt/riscv/riscv64-unknown-elf/bin/pk /opt/riscv/bin
