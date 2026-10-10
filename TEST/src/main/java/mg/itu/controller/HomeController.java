package mg.itu.controller;

import com.framework.annotation.Controller;
import com.framework.annotation.Url;
import com.framework.model.VueData;

@Controller
public class HomeController {

    @Url(value = "/home", method = "GET")
    public VueData home() {
        VueData vueData = new VueData();
        vueData.setVue("home");
        vueData.setData("message", "Bonjour et bienvenue dans home");
        return vueData;
    }

    @Url(value = "/about", method = "GET")
    public void about() {
        System.out.println("Méthode about exécutée !");
    }

    @Url("/andrana")
    public VueData andranaGet() {
        VueData vueData = new VueData();
        vueData.setVue("andrana");
        vueData.setData("message", "Bonjour et bienvenue dans andrana");
        return vueData;
    }

    @Url(value = "/andrana", method = "POST")
    public VueData andrana() {
        VueData vueData = new VueData();
        vueData.setVue("andrana");
        vueData.setData("message", "Données envoyées avec succès");
        return vueData;
    }

    @Url(value = "/inscription")
    public VueData inscription() {
        VueData vueData = new VueData();
        vueData.setVue("inscription");
        return vueData;
    }

    @Url(value = "/inscription", method = "POST")
    public VueData confirmation(String nom, int age) {
        VueData vue = new VueData();
        vue.setVue("confirmation");
        vue.setData("nom", nom);
        vue.setData("age", age);
        return vue;
    }
}