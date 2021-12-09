<html>
    <body>
        <h1><?php echo $_POST["ResortChoice"]; ?></h1>
        <?php
            // get credentials
            $config = parse_ini_file("../private/config.ini");
            $server = $config["servername"];
            $username = $config["username"];
            $password = $config["password"];
            $database = "zsahlin_DB";

            // connect
            $conn = mysqli_connect($server, $username, $password, $database);

            // check connection
            if (!$conn) {
                echo "cant connect";
                die("Connection failed: " . mysqli_connect_error()); 
            }

            // query
            $query = "select name, state, country, base_elev, summit_elev, acres, pass FROM resort Where name=?;";

            // initialize prepared statement
            $stmt = $conn->stmt_init();
            $stmt->prepare($query);

            // bind the parameter to the query (s=string)
            $stmt->bind_param("s", $_POST['ResortChoice']);

            // execute the statement and bind the result
            $stmt->execute();
            $stmt->bind_result($name, $state, $country, $base_elev, $summit_elev, $acres, $pass);

            while ($stmt->fetch()) {
                echo "State: " . $state . "<br>";
                echo "Country: " .$country . "<br>";
                echo "Base elevation: " . $base_elev . "<br>";
                echo "Summit elevation: " . $summit_elev . "<br>";
                echo "Skiable acres: " . $acres . "<br>";
                echo "Group pass: " . $pass . "<br>";
            }
        ?>
        <p/>
        <table>
            <thead>
                <tr>
                    <td>City Name</td>
                    <td>Province</td>
                    <td>Population</td>
                </tr>
            </thead>
            <tbody>
                <?php
                    // query
                    $query = "SELECT c.city_name, c.province_name, c.population FROM city c WHERE c.country_code = ?;";

                    // initialize prepared statement
                    $stmt = $conn->stmt_init();
                    $stmt->prepare($query);

                    // bind the parameter to the query (s=string)
                    $stmt->bind_param("s", $country_code);

                    // execute the statement and bind the result
                    $stmt->execute();
                    $stmt->bind_result($city_name, $province_name, $population);

                    while($stmt->fetch()) {
                    ?>
                        <tr>
                            <td><?php echo $city_name ?></td>
                            <td><?php echo $province_name ?></td>
                            <td><?php echo $population . "<br>"?></td>
                        </tr>
                    <?php
                    }
                    ?>
            </tbody>
        </table>
    </body>
</html>