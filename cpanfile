requires "Exporter" => "0";
requires "Pod::Spell::CommonMistakes" => "0.01";
requires "Test::Builder" => "0.94";
requires "Test::Pod" => "1.40";
requires "parent" => "0";
requires "perl" => "5.006";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "File::Spec" => "0";
  requires "File::Temp" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Test::More" => "0.88";
  requires "perl" => "5.006";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "Module::Build::Tiny" => "0.039";
  requires "perl" => "5.006";
};

on 'develop' => sub {
  requires "version" => "0.9901";
};
