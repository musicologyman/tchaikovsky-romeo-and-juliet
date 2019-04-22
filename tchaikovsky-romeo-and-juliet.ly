\version "2.18.2"

\include "../lilypond-page-sizes/paper-sizes.ily"
\include "../lilypond-functions/functions.ily"

\header {
  tagline = ##f
}

\layout {
  \context {
    \Score
    \remove "Bar_number_engraver"
  }
  \context {
    \Staff
    \remove Time_signature_engraver
  }
}

globalIntro = {
  \key fis \minor
  \time 4/4
}

exampleI = \relative a {
  \clef treble
  \globalIntro
  a2 \p ^\markup \italic "clarinets" b
  cis d
  fis e4 d |
  \newSpacingSection
  \override Score.SpacingSpanner #'spacing-increment = #2.5
  fis2. \< r4 \! |
  \newSpacingSection
  \revert Score.SpacingSpanner #'spacing-increment
  gis _\markup { \italic { poco più } \dynamic f } gis a gis
  fis2 e
  r b4 \p cis |
  d d fis d |
  cis2 b |
  cis1 ~ cis4
}

\book {
  \paper {
    #(set-paper-size "size 8-1")
    indent = 0 \in
    print-page-number = ##t
  }
  \score {
    \new Staff \exampleI
    \layout {
      \context {
        \Staff
        \consists Time_signature_engraver
      }
    }
    \midi { \tempo 2 = 60 }
  }
}

ignore = \override NoteColumn #'ignore-collision = ##t

exampleIITop = \relative cis' {
  \clef treble
  \globalIntro
  \partial 2
  r2
  R1
  r2
  <<
    \new Voice {
      \voiceOne
      \ignore
      \tieDown cis2-> ~ cis1 ~ \stemDown cis2
    }
    \new Voice {
      \voiceTwo
      s2
      \once \override Script #'Y-offset = #1
      gis'1^> fis2
    }
    \new Voice {
      \voiceThree
      s2 r2 cis'2-> ~ cis
    }
  >>
}

exampleIIDynamics = {
  \time 4/4
  \partial 2
  s2 \p
}

exampleIIBottom = \relative eis {
  \clef bass
  \globalIntro
  \partial2
  <<
    { s2 r2 eis2 ~ eis1 ~ eis fis2 }
    \\
    { cis2 ( d1 cis2 b a1) ~ a2 }
  >>

}

\book {
  \paper {
    #(set-paper-size "size 4-2")
    indent = 0 \in
  }
  \score {
    <<
      \new Staff \exampleIITop
      \new Dynamics \exampleIIDynamics
      \new Staff \exampleIIBottom
    >>
    \layout {
      \context {
        \Staff
        \remove Time_signature_engraver
      }

    }
    \midi { \tempo 2 = 60 }
  }

}

exampleIIITop = \relative fis'' {
  \clef treble
  \globalIntro
  \partial 2
  <<
    \new Voice {
      \voiceOne
      fis2
      g1
      (fis2 e
      eis fis)
    }
    \new Voice {
      \voiceTwo
      s2
      g,\rest bes-> ~
      ( bes1 ~
      bes2 a)
    }
  >>
}

exampleIIIBottom = \relative d' {
  \clef bass
  \globalIntro
  \partial 2
  r2
  R1
  <<
    \new Voice {
      \voiceOne
      d1-> ~ d
    }
    \new Voice {
      \voiceThree
      s1
      gis,!2 a
    }
    \new Voice {
      \voiceFour
      d,2\rest g->
      d1
    }
  >>

}

\book {
  \paper {
    #(set-paper-size "size 4-2")
    indent = 0 \in
  }
  \score {
    <<
      \new Staff \exampleIIITop
      \new Staff \exampleIIIBottom
    >>
    \layout {
      \context {
        \Staff
        \remove Time_signature_engraver
      }

    }
    \midi { \tempo 2 = 60 }
  }

}

globalIntroII = {
  \key aes \major
  \time 4/4
}

exampleIVTop = \relative f'' {
  \clef treble
  \globalIntroII
  <<
    {
      s1 ^\markup \italic "flutes and clarinets"
      s2 es
      aes1
      s2 ges ~
      ges bes
      s aes
      d e
    } \\
    {
      f,1
      ges
      s2 f2
      bes1
      s1
      c1
      s1
    }
  >>
  \ottava #1
  \set Staff.ottavation = #"one octave higher"
  aes'1 ~
  aes1
  bes,
  des2 e
  aes1 ~
  aes1
}

exampleIVDynamics = {
  s1 \ppPocoAPocoCresc
  s1 * 4
  s4 s4 \< s2
  s1
  s1 \mf \>
  s1 \p
}

exampleIVBottom = \relative es' {
  \clef treble
  \globalIntroII
  r4 es ^\markup \italic "cellos"
  _\markup \italic "dolce"
  (f es
  des) f (es des
  ces) es (des ces
  bes) ces (des ces
  bes) \clef bass aes (ges f
  f) g! \< (aes bes
  c!) \! d \> (c bes
  aes8) r \!
  \clef treble
  aes'4 \mf ^\markup \italic "harp" c f |
  aes c f aes
  R1
  R1
  r4 aes,,4 c f |
  aes c f aes
}


\book {
  \paper {
    #(set-paper-size "size 8-2")
    indent = 0 \in
    print-page-number = ##f
  }
  \score {
    <<
      \new Staff \exampleIVTop
      \new Dynamics \exampleIVDynamics
      \new Staff \exampleIVBottom
    >>
    \layout {
      \context {
        \Staff
        \remove Time_signature_engraver
      }

    }
    \midi { \tempo 2 = 60 }
  }

}

globalExposition = {
  \key b \minor
  \time 4/4
}

exampleV = \relative b' {
  \clef treble
  \globalExposition
  b4 ^\markup \bold "Allegro giusto" \f fis'16 fis fis8
  r8 b,4 cis8 |
  \repeat unfold 2 { d8. cis16 b4 r8 d cis b }
  d g r16 g, (a b c dis e fis
  #(ly:expect-warning (_ "maybe input should specify polyphonic voices"))
  #(ly:expect-warning (_ "adding note head to incompatible stem (type = 1/8)"))
  \once \override Stem #'duration-log = #3
  g)
  \clef bass cis,, ([b bes]
  a aes g fis f8 )
}

\book {
  \paper {
    #(set-paper-size "size 8-1")
    indent = 0 \in
    print-page-number = ##f
  }
  \score {
    \new Staff \exampleV
    \layout { }
    \midi { \tempo 4 = 100 }
  }
}

globalLoveTheme = {
  \key des \major
  \time 4/4
}

exampleVI = \relative aes' {
  \clef treble
  \globalLoveTheme
  r2 aes ~ ^\markup \italic "violas and English horn"
  _\markup \italic "dolce"
  aes4 c, (des es
  bes aes) des2 ~
  des bes4 (c
  a2) f' ~
  f4 \clef bass aes, (bes ces)
  f, ges beses2 ~
  (beses aes
  des,4)
}

\book {
  \paper {
    #(set-paper-size "size 8-1")
    indent = 0 \in
    print-page-number = ##t
  }
  \score {
    \new Staff \exampleVI
    \layout { }
    \midi { \tempo 4 = 90 }
  }
}

exampleVII = \relative aes' {
  \clef treble
  \globalLoveTheme
  \partial 4
  a4 \pp ^\markup \italic "violins (muted)"
  (es' a, es') a,
  (ges' f es) a,
  (es' a, es') a,
  (ges' f es) des
  (c des c) des
  (es aes, ~ aes) des
  (c des c) des
  (es aes, ~ aes) a
  (es' a, es') a,
  (ges' f es) a,
  (es' a, es')
  \stopStaff
  \once \override TextScript #'Y-offset = #-0.5
  s32 ^\markup \italic "etc."
}

\book {
  \paper {
    #(set-paper-size "size 8-1")
    indent = 0 \in
    print-page-number = ##f
  }
  \score {
    \new Staff \exampleVII
    \layout { }
    \midi { \tempo 4 = 100 }
  }
}

exampleVIII = \relative d'' {
  \clef treble
  \globalExposition
  \override TextScript #'X-offset = #3.0
  d8 b,16 \f _\markup \italic "violins" (cis
  d8) b16 (cis d8) b16 (cis d8) b16 (cis d8)
  \once \override DynamicText #'Y-offset = #4.0
  b''16 ^\f ^\markup \italic "woodwinds" ([bis] cis8)
  \revert TextScript #'X-offset
  \repeat unfold 3 { b16 (bis cis8) }
  e,,16 _\markup \italic "violins" ([fis] g8)
  \repeat unfold 3 { e16 (fis g8) }
  cis'16 ^\markup \italic "woodwinds" ([d] e8) cis16 (d e8) cis16 (d e8) cis16 (d e8)
}

\book {
  \paper {
    #(set-paper-size "size 8-1.5")
    indent = 0 \in
    print-page-number = ##f
  }
  \score {
    \new Staff \exampleVIII
    \layout { }
    \midi { \tempo 4 = 60 }
  }
}

exampleIXTop = \relative d''' {
  \clef treble
  \globalExposition
  \partial 2
  \set beamExceptions = #'()
  \set baseMoment = #(ly:make-moment 1/8)
  \set beatStructure = #'(2 2 2 2)
  \ottava #1
  \set Staff.ottavation = #"an octave higher"
  r2
  d8 \f r a'4~ a8 d, d e |
  f8. e16 d8 r r d d f
  g8. f16 e8 r r d' cis8. a16 |
  d8
}

exampleIXBottom = \relative d {
  \clef bass
  \globalExposition
  \partial 2
  \set beamExceptions = #'()
  \set baseMoment = #(ly:make-moment 1/8)
  \set beatStructure = #'(2 2 2 2)
  d8 \mf r a'4 ~
  a8 d, d e f8. e16 d8 r
  r8 d d f g8. f16 e8 r
  r d' cis8. a16 d8 r r4 |
  s8
}

\book {
  \paper {
    #(set-paper-size "size 8-2.5")
    indent = 0 \in
    print-page-number = ##f
  }
  \score {
    <<
      \new Staff \exampleIXTop
      \new Staff \exampleIXBottom
    >>
    \layout {
      \context {
        \Staff
        \remove Time_signature_engraver
      }

    }
    \midi { \tempo 2 = 72 }
  }

}