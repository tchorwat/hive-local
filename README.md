# tchorwat/hive-local
Docker image with hive setup dedicated to work with local fs storage (for evaluation, testing & development purpose). This image is not intended to run as production environment due the unsecure default configuration.

## Quick reference
* Project source repository: (https://github.com/tchorwat/hive-local)
* In case of any bugs raise a ticket through GitHub (https://github.com/tchorwat/hive-local/issues) issues page, please.
* Supported architectures: `amd64`

## Usage

### Starting hiveserver2 deamon

To run hiveserver2 instance simply run:
```
docker run -d --name hive -p 10000:10000/tcp tchorwat/hive-local
```

The command above will run hiveserver2 instance end expose binary interface over 10000 port.

### Starting beeline with embedded hiveserver2

You can run beeline with embedded server with:
```
docker run -it --rm tchorwat/hive-local beeline
```

### Custom settings

It is recommended to bind host directory to `/data` container directory, like:
```
docker run -d --name hive \
  -p 10000:10000/tcp \
  -v <full path of your data dir>:/data \
  tchorwat/hive-local
```


If you want to customize default [file](hive-site.xml) file, bind it to `/hive/conf`:
```
docker run -d --name hive \
  -p 10000:10000/tcp \
  -v <full path of your data dir>:/data \
  -v <full path to your hive-site.xml:/hive/conf/hive-site.xml \
  tchorwat/hive-local
```

You can also pass Hive parameters through environment variable. By example, to expose hiveserver2 with `http` mode, just run:
```
docker run -d --name hive \
  -e HIVE_SERVER2_TRANSPORT_MODE=http \
  -p 10001:10001/tcp \
   tchorwat/hive-local
```


## License
This Docker image is built on ubuntu Docker images https://hub.docker.com/_/ubuntu. View [license information for Ubuntu](https://ubuntu.com/licensing).

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

Image contain also:
- Hive 1.2.2 binaries (https://www.apache.org/licenses/LICENSE-2.0.html)
- Hadoop 2.10.1 binaries (https://www.apache.org/licenses/LICENSE-2.0.html)

View [**tchorwat/hive-local** project MIT license](https://github.com/tchorwat/hive-local/blob/master/LICENSE)
