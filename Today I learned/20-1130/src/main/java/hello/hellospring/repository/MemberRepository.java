package hello.hellospring.repository;

import hello.hellospring.domain.Member;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

public interface MemberRepository {
    Member save(Member member);
    Optional<Member> findById(Long id);         //null을 처리하는방법 = optional로 한번 감싸서 반환하는 방법
    Optional<Member> findByName(String name);
    List<Member> findAll();
}
