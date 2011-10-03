require 'spec_helper'

describe ChefApi, "roles_for_server" do
  before do
    @chef = ChefApi.new(Factory(:chef_api_account))
  end

  it "should get the roles for the server supplied" do
    VCR.use_cassette("get_server_info") do
      @chef.roles_for_server("i-000CCfD1").should == ["some_role"]
    end
  end

  it "should return an empty array when there is no corresponding record on chef" do
    VCR.use_cassette("node_404") do
      @chef.roles_for_server("i-000DDfD1").should == []
    end
  end

  it "should return an empty array when a node is returned with no roles" do
    VCR.use_cassette("node_roles_no_role") do
      @chef.roles_for_server("i-000CiS92").should == []
    end
  end

  it "should return a failure to get info from server" do
    key = %q{-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAzraZyHf1otRz68mKP+FFtk9Inyt2T/zYEsp1Mzc++LE2Ih2v
RuJ9Vb4IhdtbQbpNcQ+6uqazYkuQyl30rUarSOwg7uLEQXvOzMyFwseRFurmw0Vx
2WNSylwBKblsO9osWSt9x0jWG4G32mGxT28aU9KefPefPrJOu981+h7CyXj/jW/N
SKDsNij/LP6NanGDUZgKVkg7thLQORKL7nbLUb+nOjVuYLoKiaBpUoVN0A8K3uUp
4nR5CMw5hc0MyAQXMsWB+nkB7QD6MDIhZCuXBX4v7VAwLNHRe7HF/aQxxLudQ/dn
YJ357jFO9KBaVf942R2MsF7+w4DmeR8VktPMNQIDAQABAoH/UL8DU0uIqBJVNcWE
O2/Dy3Ms6wAPNy+NN8nd/iOWdY7DlpAB566RRuz0Z1VIUGR127RJPJ/hcoQSCvqo
mQcB4XpbYvUxtGKoZVd+6JcMFeesPJrj3gbuUB2gVqwXm0meCTbz6uSIvjXtm2CN
4nmDzzp2rloL2nHMT5bhftKFRC1LNU+204QUJR8gBe49mlHBZL1YoKEI4/xm/iis
3/M4tG8ar8vVcPifbqJ2GdmD617MS6xZ0PuB2fj1Gk/edtLzz4nG20Lm30Z/2QSN
OnmyMevsBSxvVYW/vipHkfmnbol9z2I6OT26SPlFDGRorvahxk8rUSKabv94eG3H
ZpMBAoGBAPuWr9q8mu3SbmPhu4vg6uosoKhy0rQHnF6MrDmjMEnaJxsjTTwbdltG
jlOV8z8HK7NBQaus+qeZyBGX3gEzVcFDK6PGDbZf8wLjJdL6m27t0xN2GKELzW0L
fp5dJ3xsUk9uFstz7bOcGCHPbbZR36CROBbvTUx8tI2Q2aR/u/uxAoGBANJWewas
tuCJncFSzJIXc8LW5iDy4eow+EEWe6awEw8mjsvHzUOVH646u1FLImZqdfxPodaO
OP1g/PcYw5j0L9RPoAtGPdVzADb8XTQunSZgU8WTIen9SUy4GX9YJ6eA4dIRE7aH
pijQTYQg8XhNaUcIDADzfWuzVtUl+ADe/S3FAoGAWNzEiFINtuqYqxbUE3gCAWx5
4oWL/qKhjJPLUSBesfcn0OILKavZhivJoaRZIm359XqbI3QZpJEgpXYqp+nl5DlB
dLtDpKMHRoHMnlR+ChRedYVE9b0hdd6VfoIQrFXmTL/ptTrhPotnyqllavxILIKe
eRtVBisV6tq6xOuJDkECgYEAoatxEldMlVeRVtfSf3PhOWA+MBMfzAbpufWTAzMQ
4zNKzJz9S7XiTOO9uKVcgoXPvChlB2n3qeGTbkWtifIelTzCkgfiXR7wilL9PK+b
gLTHjvQhPB2/6mUSzAuxJxFsAS+5DDJFZ9d7zVQY5dPyWHN57n046MBGvLxbXCgJ
R9UCgYEAvyMe3D2g8O80PTyn/noBqA6rUA9kwe3gEv2BMKNM479GNCm4pGtTZ82c
Csi1+OtOusUBiXtb7m1SQmpLAha9d2SUvmziH8kithgZ7YhtDCxP2I8FHIDGioiv
0Xq95jSDFNavXmr498KAMvMkXOcCmb6l5xrXUjwcQQDU7/CINZw=
-----END RSA PRIVATE KEY-----}
    chef = ChefApi.new(Factory(:chef_api_account, :chef_server_key => key))
    VCR.use_cassette("chef_client_unauthorised") do
      chef.roles_for_server("i-000CiS92").should == "Unable to get chef data"
    end
  end
end

