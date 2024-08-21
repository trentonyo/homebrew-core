class PgCronPg17 < Formula
  desc "Run periodic jobs in PostgreSQL 17"
  homepage "https://github.com/citusdata/pg_cron"
  url "https://github.com/citusdata/pg_cron/archive/refs/tags/v1.6.4.tar.gz"
  sha256 "52d1850ee7beb85a4cb7185731ef4e5a90d1de216709d8988324b0d02e76af61"
  license "PostgreSQL"

  depends_on "postgresql@17"

  on_macos do
    depends_on "gettext" # for libintl
  end

  def postgresql
    Formula["postgresql@17"]
  end

  def install
    # Work around for ld: Undefined symbols: _libintl_ngettext
    # Issue ref: https://github.com/citusdata/pg_cron/issues/269
    ENV["PG_LDFLAGS"] = "-lintl" if OS.mac?

    system "make", "install", "PG_CONFIG=#{postgresql.opt_bin}/pg_config",
                              "pkglibdir=#{lib/postgresql.name}",
                              "datadir=#{share/postgresql.name}"
  end

  test do
    ENV["LC_ALL"] = "C"
    pg_ctl = postgresql.opt_bin/"pg_ctl"
    psql = postgresql.opt_bin/"psql"
    port = free_port

    system pg_ctl, "initdb", "-D", testpath/"test"
    (testpath/"test/postgresql.conf").write <<~EOS, mode: "a+"

      shared_preload_libraries = 'pg_cron'
      port = #{port}
    EOS
    system pg_ctl, "start", "-D", testpath/"test", "-l", testpath/"log"
    begin
      system psql, "-p", port.to_s, "-c", "CREATE EXTENSION \"pg_cron\";", "postgres"
    ensure
      system pg_ctl, "stop", "-D", testpath/"test"
    end
  end
end
