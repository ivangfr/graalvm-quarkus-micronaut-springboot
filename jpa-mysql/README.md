# graalvm-quarkus-micronaut-springboot
## `> jpa-mysql`

In this example, we will implement three versions of a Restful API for handling Books using `Quarkus`, `Micronaut` and `Spring Boot` Frameworks. The books information are store in a database.

## Applications

- ### [quarkus-jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql/quarkus-jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [micronaut-jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql/micronaut-jpa-mysql#graalvm-quarkus-micronaut-springboot)
- ### [springboot-jpa-mysql](https://github.com/ivangfr/graalvm-quarkus-micronaut-springboot/tree/master/jpa-mysql/springboot-jpa-mysql#graalvm-quarkus-micronaut-springboot)

## Start Environment

- Open a terminal and navigate to `graalvm-quarkus-micronaut-springboot/jpa-mysql` folder

- Run the command
  ```
  docker-compose up -d
  ```

- Wait for `MySQL` container to be up and running. To check it, run
  ```
  docker-compose ps
  ```

## Useful Commands

- **MySQL**

  - Reset tables script (make sure you are in `graalvm-quarkus-micronaut-springboot/jpa-mysql` folder)
    ```
    ./reset-tables.sh
    ```

  - Connecting to `MySQL Monitor`
    - JVM
      ```
      docker exec -it mysql mysql -uroot -psecret --database bookdb_jvm
      ```
    - Native
      ```
      docker exec -it mysql mysql -uroot -psecret --database bookdb_native
      ```

    Insite `MySQL Monitor` terminal
    ```
    show tables;
    select * from quarkus_books;
    select * from micronaut_books;
    select * from springboot_books;
    ```

## Shutdown

- In a terminal, make sure you are in `graalvm-quarkus-micronaut-springboot/jpa-mysql` folder

- To stop and remove docker-compose containers, networks and volumes, run
  ```
  docker-compose down -v
  ```
