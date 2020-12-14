package hello.hellospring.controller;

//입력해서 db로 넘어간 정보들을 저장하는 컨트롤..러? 인가?

public class MemberForm {
    private String name;          //createMemberFrom의 input의 name값이 들어옴

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
