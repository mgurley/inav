survey "Pregnancy Visit 1 Instrument and SAQ (EN, PB, HI)" do

  section "Interview Introduction" do
    label "empty"
  end
  section "Current Pregnancy Information" do

    q "Did you use a home pregnancy test to help find out you were pregnant?", :pick => :one
    a "Yes"
    a "No"
    a "REFUSED" 
    a "DON'T KNOW"

    q "Are you pregnant with a single baby (singleton), twins, or triplets or other multiple births?", :pick => :one
    a "Singleton"
    a "Twins"
    a "Triplets or higher"
    a "REFUSED"
    a "DON'T KNOW"

    q "Where do you plan to deliver your (baby/babies)?", :pick => :one
    a "In a hospital,"
    a "A birthing center,"
    a "At home, or"
    a "Some other place?"
    a "REFUSED"
    a "DON'T KNOW"

    q "What is the name and address of the place where you are planning to deliver your (baby/babies)?"
    a "Name of Birth hospital/birthing center", :string
    a "Street address", :string
    a "City", :string
    a "State", :string
    a "Zip Code", :string
    a "REFUSED"
    a "DON'T KNOW"
  end

 section "Medical History" do
    label "empty"
  end
 section "Health Insurance" do
    label "empty"
  end
 section "Housing Characteristics" do
    label "empty"
  end
 section "Pets" do
    label "empty"
  end
 section "Household Composition and Demographics" do
    label "empty"
  end
 section "Commuting" do
    label "empty"
  end
 section "Family Income" do
    label "empty"
  end
 section "Tracing Questions" do
    label "empty"
  end



end
