require 'analyzer'

describe 'Analyze' do
  context '.call' do
    before :each do
      @play = <<eos
      <PLAY>
      <TITLE>The Tragedy of Macbeth</TITLE>
      <FM>
        <P>Text placed in the public domain by Moby Lexical Tools, 1992.</P>
        <P>SGML markup by Jon Bosak, 1992-1994.</P>
        <P>XML version by Jon Bosak, 1996-1998.</P>
        <P>This work may be freely copied and distributed worldwide.</P>
      </FM>
      <PERSONAE>
        <TITLE>Dramatis Personae</TITLE>
        <PERSONA>DUNCAN, king of Scotland.</PERSONA>
        <PGROUP>
          <PERSONA>MALCOLM</PERSONA>
          <PERSONA>DONALBAIN</PERSONA>
          <GRPDESCR>his sons.</GRPDESCR>
        </PGROUP>
        <PGROUP>
          <PERSONA>MACBETH</PERSONA>
          <PERSONA>BANQUO</PERSONA>
          <GRPDESCR>generals of the kings army.</GRPDESCR>
        </PGROUP>
        <PGROUP>
          <PERSONA>MACDUFF</PERSONA>
          <PERSONA>LENNOX</PERSONA>
          <PERSONA>ROSS</PERSONA>
          <PERSONA>MENTEITH</PERSONA>
          <PERSONA>ANGUS</PERSONA>
          <PERSONA>CAITHNESS</PERSONA>
          <GRPDESCR>noblemen of Scotland.</GRPDESCR>
        </PGROUP>
      </PERSONAE>
      <SCNDESCR>SCENE  Scotland: England.</SCNDESCR>
      <PLAYSUBT>MACBETH</PLAYSUBT>
      <ACT>
        <TITLE>ACT I</TITLE>
        <SCENE>
          <TITLE>SCENE I.  A desert place.</TITLE>
          <STAGEDIR>Thunder and lightning. Enter three Witches</STAGEDIR>
          <SPEECH>
            <SPEAKER>MACDUFF</SPEAKER>
            <LINE>Who dares receive it other,</LINE>
            <LINE>As we shall make our griefs and clamour roar</LINE>
            <LINE>Upon his death?</LINE>
          </SPEECH>
          <SPEECH>
            <SPEAKER>MACBETH</SPEAKER>
            <LINE>I am settled, and bend up</LINE>
            <LINE>Each corporal agent to this terrible feat.</LINE>
            <LINE>Away, and mock the time with fairest show:</LINE>
            <LINE>False face must hide what the false heart doth know.</LINE>
            
          </SPEECH>
          <STAGEDIR>Exeunt</STAGEDIR>
        </SCENE>
      </ACT>
      <ACT>
        <TITLE>ACT II</TITLE>
        <SCENE>
          <TITLE>SCENE I.  A desert place.</TITLE>
          <STAGEDIR>Thunder and lightning. Enter three Witches</STAGEDIR>
          <SPEECH>
            <SPEAKER>MACDUFF</SPEAKER>
            <LINE>Who dares receive it other,</LINE>
            <LINE>As we shall make our griefs and clamour roar</LINE>
            <LINE>Upon his death?</LINE>
          </SPEECH>
          <SPEECH>
            <SPEAKER>MACBETH</SPEAKER>
            <LINE>I am settled, and bend up</LINE>
            <LINE>Each corporal agent to this terrible feat.</LINE>
            <LINE>Away, and mock the time with fairest show:</LINE>
            <LINE>False face must hide what the false heart doth know.</LINE>
            
          </SPEECH>
          <STAGEDIR>Exeunt</STAGEDIR>
        </SCENE>
      </ACT>
    </PLAY>

eos
    end
    it 'analyzes xml and get number of characters in play' do
      
      analyzer = Analyzer.new(@play)
      characters = analyzer.characters
      expect(characters.size).to eql(11)
    end
    
    it 'analyzes xml and gets lines spoken by MACDUFF' do
      analyzer = Analyzer.new(@play)
      expect(analyzer.lines_for('MACDUFF')).to eq 6
      
    end
    
    it 'analyzes xml and gets lines spoken by MACBETH' do
      analyzer = Analyzer.new(@play)
      expect(analyzer.lines_for('MACBETH')).to eq 8
      
    end
  end
end