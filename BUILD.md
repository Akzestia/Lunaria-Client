### Building client
## Todo

```sh
mkdir build
cd build
```
Set server's ip address
```sh
export LUNARIA_SERVER_IP=<your_lunaria_server_ip>
```
Set client default language: en, ja, ua
```sh
export LUNARIA_CLIENT_LANGUAGE="en"
```
Building with ninja
```cmake
cmake -G Ninja .. && ninja
```

