package hello.hellospring.service;

import hello.hellospring.domain.Member;
import hello.hellospring.repository.MemberRepository;
import hello.hellospring.repository.MemoryMemberRepository;

import java.util.List;
import java.util.Optional;

public class MemberService {
    private final MemberRepository memberRepository = new MemoryMemberRepository();

    //회원가입
    public Long join(Member member) {
        validateDuplicateMember(member);      //중복회원검증
        memberRepository.save(member);
        return member.getId();
    }

    public void validateDuplicateMember(Member member) {
        memberRepository.findByName(member.getName())                           //memberRepository. 인스턴스자체의 반환타입이 optional<Member>이므로 optional의 내장객체 사용가능(ifPresent사용)
                .ifPresent(m -> {
                    throw new IllegalStateException("이미 존재하는 아이디입니다");
                });
    }

    //전체회원조회
    public List<Member> findMembers() {
        return memberRepository.findAll();
    }

    public Optional<Member> findOne(Long memberID) {
        return memberRepository.findById(memberID);
    }
}
