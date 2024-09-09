### Building client
## Todo
> Note: client is still under development, so it's not yet possible to build it from source code

### Clone the repository
```sh
git clone https://github.com/Akzestia/Lunaria-Client.git
cd Lunaria-Client
```
### Create build directory
```sh
mkdir build
cd build
```
### Set server's ip address
```sh
export LUNARIA_SERVER_IP=<your_lunaria_server_ip>
```
### Set client default language: en, ja, ua
```sh
export LUNARIA_CLIENT_LANGUAGE="en"
```
### Building with ninja
```cmake
cmake -G Ninja .. && ninja
```

