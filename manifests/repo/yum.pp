# Placeholder for when there are official repos
class beats::repo::yum {

  yumrepo { 'elastic_co':
    ensure    => 'present',
    baseurl   => 'https://packages.elastic.co/beats/yum/el/$basearch',
    descr     => 'Official Elastic Beats Repository',
    enabled   => '1',
    gpgkey    => 'https://packages.elastic.co/GPG-KEY-elasticsearch',
    gpgcheck  => '1',

  }


}

