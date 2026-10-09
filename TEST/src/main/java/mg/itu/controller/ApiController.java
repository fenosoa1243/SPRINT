package mg.itu.controller;

import com.framework.annotation.Controller;
import com.framework.annotation.RestAPI;
import com.framework.annotation.Url;
import mg.itu.model.User;

import java.util.Arrays;
import java.util.List;

@Controller
public class ApiController {

    @RestAPI
    @Url(value = "/api/users", method = "GET")
    public List<User> getUsers() {
        return Arrays.asList(
                new User(1, "Rakoto"),
                new User(2, "Rasoa"));
    }
}