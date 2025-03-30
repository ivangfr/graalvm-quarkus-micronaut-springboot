# graalvm-quarkus-micronaut-springboot
## `> jpa-mysql`

In this category, we have implemented three versions of a Restful API for handling Books using `Quarkus`, `Micronaut` and `Spring Boot` Frameworks. The books information are store in a database.

## Applications

- ### [quarkus-jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql/quarkus-jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [micronaut-jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql/micronaut-jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [springboot-jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql/springboot-jpa-mysql#graalvm-quarkus-micronaut-springboot)

## Start Environment

- Open a terminal and navigate to the `graalvm-quarkus-micronaut-springboot/jpa-mysql` folder

- Run the command
  ```bash
  podman compose up -d
  ```

- Wait for `MySQL` container to be up and running. To check it, run
  ```bash
  podman compose ps
  ```

## Useful Commands

- **MySQL**

  - Reset tables script (make sure you are in the `graalvm-quarkus-micronaut-springboot/jpa-mysql` folder)
    ```bash
    ./reset-tables.sh
    ```

  - Connecting to `MySQL Monitor`
    - JVM
      ```bash
      podman exec -it -e MYSQL_PWD=secret mysql mysql -uroot --database bookdb_jvm
      ```
    - Native
      ```bash
      podman exec -it -e MYSQL_PWD=secret mysql mysql -uroot --database bookdb_native
      ```

    Insite `MySQL Monitor` terminal
    ```sql
    show tables;
    select * from quarkus_books;
    select * from micronaut_books;
    select * from springboot_books;
    ```

## Shutdown

- In a terminal, make sure you are in the `graalvm-quarkus-micronaut-springboot/jpa-mysql` folder

- To stop and remove compose containers, networks and volumes, run
  ```bash
  podman compose down -v
  ```
