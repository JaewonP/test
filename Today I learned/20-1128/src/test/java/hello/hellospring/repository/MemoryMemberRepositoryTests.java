package hello.hellospring.repository;

import hello.hellospring.domain.Member;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.assertj.core.api.Assertions.*;

//test페이지에서는 각 @test들을 class단위에서 test하면, 각 test의 순서를 보장할 수 없기떄문에, 한 테스트끝나고 저장된정보를 지우는 작업이 필요
class MemoryMemberRepositoryTests {
    MemoryMemberRepository repository = new MemoryMemberRepository();

    @AfterEach       //테스트하나 끝날때마다 저장된 정보를 지워줌
    public void afterEach(){
        repository.clearStore();
    }

    @Test
    public void save() {
        Member member = new Member();
        member.setName("오구");

        repository.save(member);

        Member result = repository.findById(member.getId()).get();  //optional에있는걸 꺼내올때 get()을 쓴다
//      Assertions.assertEquals(member, result);
        assertThat(member).isEqualTo(result);
    }
    
    @Test
    public void findByName(){
        Member member1 = new Member();
        member1.setName("봄구");  
        repository.save(member1);

        Member member2 = new Member();
        member2.setName("황구");
        repository.save(member2);

        Member result = repository.findByName("봄구").get();
        assertThat(result).isEqualTo(member1);

    }

    @Test
    public void findALL(){
        Member member1 = new Member();
        member1.setName("보로봄");
        repository.save(member1);

        Member member2 = new Member();
        member2.setName("고로곤");
        repository.save(member2);

        List<Member> result = repository.findAll();

        assertThat(result.size()).isEqualTo(2);
    }
}
