# -*- encoding: utf-8 -*-
# stub: net-ping 1.7.7 ruby lib

Gem::Specification.new do |s|
  s.name = "net-ping"
  s.version = "1.7.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Chernesky"]
  s.date = "2015-01-23"
  s.description = "    The net-ping library provides a ping interface for Ruby. It includes\n    separate TCP, HTTP, LDAP, ICMP, UDP, WMI (for Windows) and external ping\n    classes.\n"
  s.email = "chris.netping@tinderglow.com"
  s.extra_rdoc_files = ["README.md", "CHANGES", "doc/ping.txt"]
  s.files = ["CHANGES", "README.md", "doc/ping.txt"]
  s.homepage = "https://github.com/chernesk/net-ping"
  s.licenses = ["Artistic 2.0"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.4.5"
  s.summary = "A ping interface for Ruby."

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
