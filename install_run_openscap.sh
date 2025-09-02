
sudo dnf install openscap openscap-scanner

wget https://github.com/ComplianceAsCode/content/releases/download/v0.1.76/scap-security-guide-0.1.76.zip
unzip scap-security-guide-0.1.76.zip scap-security-guide-0.1.76/ssg-al2023-ds.xml


oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis \
  --results results.xml \
  --report report.html \
  scap-security-guide-0.1.76/ssg-al2023-ds.xml


# list profiles
oscap info "scap-security-guide-0.1.76/ssg-al2023-ds.xml"



oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis_server_l1 \
  --results results_l1.xml \
  --report report_l1.html \
  scap-security-guide-0.1.76/ssg-al2023-ds.xml
