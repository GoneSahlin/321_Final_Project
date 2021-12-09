<html>
    <body>
        <h1>Ski Resort Database</h1>
        <p/>
        <form action="resort_info.php" method="POST">
            <select name="ResortChoice">
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
                    $query = "SELECT name FROM resort;";
                    $result = mysqli_query($conn, $query); 

                    while($row=mysqli_fetch_assoc($result)) {
                ?>
                <option value="<?php echo $row['name']; ?>"><?php echo $row['name']; ?></option>
                <?php } ?>
            </select>
            <?php mysqli_close($conn); ?>
            <input type="submit" value="Execute Query"/>
        </form>
    </body>
</html>
