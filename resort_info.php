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
        <h3>Chairlifts</h3>
        <table style="border-spacing:20px 0">
            <thead style="font-weight:bold">
                <tr>
                    <td>Lift Name</td>
                    <td>Capacity</td>
                    <td>Status</td>
                </tr>
            </thead>
            <tbody>
                <?php
                    // query
                    $query = "SELECT name, capacity, status FROM chairlift WHERE resort = ?;";

                    // initialize prepared statement
                    $stmt = $conn->stmt_init();
                    $stmt->prepare($query);

                    // bind the parameter to the query (s=string)
                    $stmt->bind_param("s", $_POST['ResortChoice']);

                    // execute the statement and bind the result
                    $stmt->execute();
                    $stmt->bind_result($lift_name, $capacity, $status);

                    while($stmt->fetch()) {
                    ?>
                        <tr>
                            <td><?php echo $lift_name ?></td>
                            <td style="text-align:right"><?php echo $capacity ?></td>
                            <td style="text-align:right"><?php echo $status . "<br>"?></td>
                        </tr>
                    <?php
                    }
                    ?>
            </tbody>
        </table>
        <p/>
        <h3>Runs</h3>
        <table style="border-spacing:20px 0">
            <thead style="font-weight:bold">
                <tr>
                    <td>Run Name</td>
                    <td>Difficulty</td>
                    <td>Status</td>
                </tr>
            </thead>
            <tbody>
                <?php
                    // query
                    $query = "SELECT name, difficulty, status FROM run WHERE resort = ?;";

                    // initialize prepared statement
                    $stmt = $conn->stmt_init();
                    $stmt->prepare($query);

                    // bind the parameter to the query (s=string)
                    $stmt->bind_param("s", $_POST['ResortChoice']);

                    // execute the statement and bind the result
                    $stmt->execute();
                    $stmt->bind_result($run_name, $difficulty, $status);

                    while($stmt->fetch()) {
                    ?>
                        <tr>
                            <td><?php echo $run_name ?></td>
                            <td style="text-align:right"><?php echo $difficulty ?></td>
                            <td style="text-align:right"><?php echo $status . "<br>"?></td>
                        </tr>
                    <?php
                    }
                    ?>
            </tbody>
        </table>
        <h3>Day Ticket Prices</h3>
        <table>
            <tbody>
                <?php
                    $query = "SELECT age_min, age_max, price FROM ticket WHERE resort = ? AND type='day';";

                    // initialize prepared statement
                    $stmt = $conn->stmt_init();
                    $stmt->prepare($query);

                    // bind the parameter to the query (s=string)
                    $stmt->bind_param("s", $_POST['ResortChoice']);

                    // execute the statement and bind the result
                    $stmt->execute();
                    $stmt->bind_result($age_min, $age_max, $price);

                    while($stmt->fetch()) {
                        if ($age_max == NULL) {
                        ?>
                            <tr>
                                <td style="padding-right:20px"><?php echo "Ages " . $age_min . "+" ?></td>
                                <td style="text-align:right"><?php echo "$" . $price . "<br>" ?></td>
                            </tr>
                        <?php
                        }
                        else {
                        ?>
                            <tr>
                                <td style="padding-right:20px"><?php echo "Ages " . $age_min . "-" . $age_max ?></td>
                                <td style="text-align:right"><?php echo "$" . $price . "<br>" ?></td>
                            </tr>
                        <?php
                        }
                    }
                ?>
            </tbody>
        </table>
    </body>
</html>