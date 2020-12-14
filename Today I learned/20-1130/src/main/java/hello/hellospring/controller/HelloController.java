package hello.hellospring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HelloController {
    @GetMapping("hello")
    public String hello(Model model) {
        model.addAttribute("data", "hello~!");
        return "hello";
    }

    @GetMapping("hello-mvc")        //mvc방식에서 html로 view를 쓰는것을 테스트해보기 위함
    public String helloMvc(@RequestParam("name") String name, Model model) {
        model.addAttribute("name", name);
        return "hello-template";
    }

    @GetMapping("hello-string")
    @ResponseBody        //"API"로 보여주는 part / 여기서 body는 html이 아닌 http의 body부분에 출력을 하라는 뜻(딱! 메서드 내부값만 출력한다) + 개발자화면에서도 똑같이 나온다
    public String helloString(@RequestParam("name") String name) {
        return "hello " + name;
    }

    @GetMapping("hello-api")
    @ResponseBody
    //api방식으로 웹에 뿌릴때 톰캣 > 컨트롤러 > HttpMessageConverter > JsonConverter(객체타입) or StringConverter(문자타입) > {name : spring}
    public Hello helloApi(@RequestParam("name") String name) {        //리턴타입이 객체면 리턴시 json사용
        Hello hello = new Hello();
        hello.setName(name);
        return hello;                 // json방식으로 리턴
    }

    static class Hello {
        private String name;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }
    }
}
