import os
from git import Repo


class PyRepo:
    def __init__(self, name, full_name, description, clone_url, timestamp, num_stars, num_forks, created_at, pushed_at):
        self._name = name
        self._full_name = full_name
        self._description = description
        self._clone_url = clone_url
        self._timestamp = timestamp
        self._last_commit_sha = None
        self._num_stars = num_stars
        self._num_forks = num_forks
        self._created_at = created_at
        self._pushed_at = pushed_at

    def __str__(self):
        return self.name

    def __eq__(self, other):
        return self.clone_url == other.clone_url

    def clone(self, output_directory):
        target = os.path.join(output_directory, self.full_name)
        repo = Repo.clone_from(self.clone_url, target)
        self.last_commit_sha = repo.head.object.hexsha

    def checkout(self, output_directory):
        repo = Repo.clone_from(self.clone_url, os.path.join(output_directory, self.name))
        git = repo.git
        git.checkout(self.last_commit_sha)

    @property
    def clone_url(self):
        return self._clone_url

    @property
    def last_commit_sha(self):
        return self._last_commit_sha

    @last_commit_sha.setter
    def last_commit_sha(self, value):
        self._last_commit_sha = value

    @property
    def timestamp(self):
        return self._timestamp

    @property
    def name(self):
        return self._name

    @property
    def full_name(self):
        return self._full_name

    @property
    def num_stars(self):
        return self._num_stars

    @property
    def num_forks(self):
        return self._num_forks

    @property
    def created_at(self):
        return self._created_at

    @property
    def pushed_at(self):
        return self._pushed_at

    def details(self):
        return "Name: %s Description: %s Stars: %d Forks: %d Created At: %s Pushed At: %s Sha: %s" % \
               (self.name, self._description, self._num_stars, self.num_forks, self.created_at, self.pushed_at, self.last_commit_sha)
