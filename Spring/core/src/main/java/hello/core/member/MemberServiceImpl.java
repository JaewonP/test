package hello.core.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MemberServiceImpl implements MemberService {

    private final MemberRepository memberRepository;

    //serviceImpl이 실행되면 생성자로 memberRepository인터페이스의 구현체가 들어온다
    @Autowired //의존관계설정-Component와 셋뚜
    public MemberServiceImpl(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    @Override
    public void join(Member member) {
        memberRepository.save(member);      //다형성에서 조상클래스타입의 참조변수  memberRepository가 자손클래스의 인스턴스를 참조가능
    }

    @Override
    public Member findMember(Long memberId) {
        return memberRepository.findById(memberId);
    }
}
